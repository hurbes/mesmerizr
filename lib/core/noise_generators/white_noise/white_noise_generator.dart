import 'dart:math';
import 'dart:typed_data';
import '../../parameters/noise_generator_parameters.dart';
import '../base_noise_generator.dart';

class WhiteNoiseGenerator extends BaseNoiseGenerator {
  WhiteNoiseGenerator(NoiseGeneratorParameters initialParameters)
      : _parameters = initialParameters,
        _random = Random();

  NoiseGeneratorParameters _parameters;
  final Random _random;
  double _phase = 0.0;

  @override
  String get name => 'White Noise';

  @override
  NoiseGeneratorParameters get parameters => _parameters;

  @override
  Float64List generateNoise(int sampleRate, int bufferSize) {
    final buffer = Float64List(bufferSize);
    final frequencyFactor = _parameters.frequency / sampleRate;
    final volumeEnvelope = _generateVolumeEnvelope(bufferSize);

    for (int i = 0; i < bufferSize; i++) {
      // Generate white noise
      double noise = (_random.nextDouble() * 2 - 1) * _parameters.amplitude;

      // Apply frequency shaping
      noise *= sin(2 * pi * _phase);
      _phase += frequencyFactor;
      if (_phase >= 1.0) _phase -= 1.0;

      // Apply volume envelope
      buffer[i] = noise * volumeEnvelope[i];
    }

    return buffer;
  }

  List<double> _generateVolumeEnvelope(int bufferSize) {
    final envelope = List<double>.filled(bufferSize, 1.0);
    final attackSamples = (_parameters.attackTime * bufferSize).round();
    final releaseSamples = (_parameters.releaseTime * bufferSize).round();

    // Attack
    for (int i = 0; i < attackSamples; i++) {
      envelope[i] = i / attackSamples;
    }

    // Release
    for (int i = 0; i < releaseSamples; i++) {
      envelope[bufferSize - 1 - i] = i / releaseSamples;
    }

    return envelope;
  }

  @override
  void updateParameters(NoiseGeneratorParameters newParameters) {
    _parameters = newParameters;
  }

  @override
  Float64List applyFilters(Float64List buffer, int sampleRate) {
    buffer = _applyLowPassFilter(buffer, sampleRate);
    buffer = _applyHighPassFilter(buffer, sampleRate);
    buffer = _applySmoothing(buffer);
    return buffer;
  }

  Float64List _applyLowPassFilter(Float64List buffer, int sampleRate) {
    final dt = 1 / sampleRate;
    final rc = 1 / (2 * pi * _parameters.lowPassCutoff);
    final alpha = dt / (rc + dt);

    final filteredBuffer = Float64List(buffer.length);
    filteredBuffer[0] = buffer[0];

    for (int i = 1; i < buffer.length; i++) {
      filteredBuffer[i] =
          filteredBuffer[i - 1] + alpha * (buffer[i] - filteredBuffer[i - 1]);
    }

    return filteredBuffer;
  }

  Float64List _applyHighPassFilter(Float64List buffer, int sampleRate) {
    final dt = 1 / sampleRate;
    final rc = 1 / (2 * pi * _parameters.highPassCutoff);
    final alpha = rc / (rc + dt);

    final filteredBuffer = Float64List(buffer.length);
    filteredBuffer[0] = buffer[0];

    for (int i = 1; i < buffer.length; i++) {
      filteredBuffer[i] =
          alpha * (filteredBuffer[i - 1] + buffer[i] - buffer[i - 1]);
    }

    return filteredBuffer;
  }

  Float64List _applySmoothing(Float64List buffer) {
    final smoothedBuffer = Float64List(buffer.length);
    final windowSize = (_parameters.smoothingFactor * buffer.length).round();

    for (int i = 0; i < buffer.length; i++) {
      int start = max(0, i - windowSize ~/ 2);
      int end = min(buffer.length - 1, i + windowSize ~/ 2);
      double sum = 0;
      for (int j = start; j <= end; j++) {
        sum += buffer[j];
      }
      smoothedBuffer[i] = sum / (end - start + 1);
    }

    return smoothedBuffer;
  }

  @override
  Uint8List convertToUint8(Float64List buffer) {
    final intBuffer = buffer.map((sample) {
      int intSample = (sample * 32767).round().clamp(-32768, 32767);
      return intSample + 32768;
    }).toList();

    final byteData = ByteData(intBuffer.length * 2);
    for (int i = 0; i < intBuffer.length; i++) {
      byteData.setUint16(i * 2, intBuffer[i], Endian.little);
    }

    return byteData.buffer.asUint8List();
  }
}
