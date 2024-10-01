import 'dart:math';
import 'dart:typed_data';
import '../../noise_generator.dart';
import '../white_noise/white_noise_generator.dart';
import '../pink_noise/pink_noise_generator.dart';
import '../brown_noise/brown_noise_generator.dart';

class MixedNoiseGenerator implements NoiseGenerator {
  final WhiteNoiseGenerator _whiteNoiseGenerator = WhiteNoiseGenerator();
  final PinkNoiseGenerator _pinkNoiseGenerator = PinkNoiseGenerator();
  final BrownNoiseGenerator _brownNoiseGenerator = BrownNoiseGenerator();

  double _whiteNoiseLevel = 0.33;
  double _pinkNoiseLevel = 0.33;
  double _brownNoiseLevel = 0.34;
  double _lowPassCutoff = 20000;
  double _highPassCutoff = 20;
  double _amplitude = 0.5;

  List<double> _previousBuffer = [];
  final Random _random = Random();

  void updateParameters({
    double? whiteNoiseLevel,
    double? pinkNoiseLevel,
    double? brownNoiseLevel,
    double? lowPassCutoff,
    double? highPassCutoff,
    double? amplitude,
  }) {
    _whiteNoiseLevel = whiteNoiseLevel ?? _whiteNoiseLevel;
    _pinkNoiseLevel = pinkNoiseLevel ?? _pinkNoiseLevel;
    _brownNoiseLevel = brownNoiseLevel ?? _brownNoiseLevel;
    _lowPassCutoff = lowPassCutoff ?? _lowPassCutoff;
    _highPassCutoff = highPassCutoff ?? _highPassCutoff;
    _amplitude = amplitude ?? _amplitude;
  }

  @override
  Uint8List generateNoise(
    int sampleRate,
    int bufferSize,
    double amplitude, [
    double? whiteNoiseLevel,
    double? pinkNoiseLevel,
    double? brownNoiseLevel,
    double? lowPassCutoff,
    double? highPassCutoff,
  ]) {
    updateParameters(
      whiteNoiseLevel: whiteNoiseLevel,
      pinkNoiseLevel: pinkNoiseLevel,
      brownNoiseLevel: brownNoiseLevel,
      lowPassCutoff: lowPassCutoff,
      highPassCutoff: highPassCutoff,
      amplitude: amplitude,
    );

    final whiteNoise =
        _whiteNoiseGenerator.generateNoise(sampleRate, bufferSize, amplitude);
    final pinkNoise =
        _pinkNoiseGenerator.generateNoise(sampleRate, bufferSize, amplitude);
    final brownNoise =
        _brownNoiseGenerator.generateNoise(sampleRate, bufferSize, amplitude);

    final mixedBuffer = Float64List(bufferSize);

    for (int i = 0; i < bufferSize; i++) {
      mixedBuffer[i] = (whiteNoise[i] * _whiteNoiseLevel +
              pinkNoise[i] * _pinkNoiseLevel +
              brownNoise[i] * _brownNoiseLevel) *
          _amplitude;
    }

    // Smooth transition between buffers
    if (_previousBuffer.isNotEmpty) {
      final transitionLength = min(bufferSize ~/ 2, _previousBuffer.length);
      for (int i = 0; i < transitionLength; i++) {
        final t = i / transitionLength;
        mixedBuffer[i] = _previousBuffer[i] * (1 - t) + mixedBuffer[i] * t;
      }
    }

    _previousBuffer = mixedBuffer.sublist(mixedBuffer.length - bufferSize ~/ 2);

    return _applyFilters(mixedBuffer, sampleRate);
  }

  Uint8List _applyFilters(Float64List buffer, int sampleRate) {
    final filteredBuffer = Float64List(buffer.length);
    double lastLowPass = 0;
    double lastHighPass = 0;

    final lowPassAlpha = 1 - exp(-2 * pi * _lowPassCutoff / sampleRate);
    final highPassAlpha = 1 - exp(-2 * pi * _highPassCutoff / sampleRate);

    for (int i = 0; i < buffer.length; i++) {
      // Low-pass filter
      lastLowPass += lowPassAlpha * (buffer[i] - lastLowPass);

      // High-pass filter
      final highPass = highPassAlpha * (lastHighPass + buffer[i] - lastLowPass);
      lastHighPass = highPass;

      filteredBuffer[i] = highPass;
    }

    // Apply additional smoothing
    for (int i = 2; i < filteredBuffer.length - 2; i++) {
      filteredBuffer[i] = (filteredBuffer[i - 2] +
              filteredBuffer[i - 1] +
              filteredBuffer[i] +
              filteredBuffer[i + 1] +
              filteredBuffer[i + 2]) /
          5;
    }

    return _convertToInt16(filteredBuffer);
  }

  Uint8List _convertToInt16(Float64List buffer) {
    final maxAmplitude = buffer.reduce((a, b) => max(a.abs(), b.abs()));
    final scaleFactor = maxAmplitude > 0 ? 32767 / maxAmplitude : 1;

    return Int16List.fromList(buffer
            .map((x) => (x * scaleFactor).round().clamp(-32767, 32767))
            .toList())
        .buffer
        .asUint8List();
  }

  @override
  String get name => 'Mixed Noise';
}
