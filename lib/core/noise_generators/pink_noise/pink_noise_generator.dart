import 'dart:math';
import 'dart:typed_data';
import '../../noise_generator.dart';

class PinkNoiseGenerator implements NoiseGenerator {
  final Random _random = Random();
  final List<double> _b = List.filled(7, 0.0);

  @override
  Uint8List generateNoise(int sampleRate, int bufferSize, double amplitude) {
    final buffer = Float64List(bufferSize);
    for (int i = 0; i < bufferSize; i++) {
      double white = _random.nextDouble() * 2 - 1;
      _b[0] = 0.99886 * _b[0] + white * 0.0555179;
      _b[1] = 0.99332 * _b[1] + white * 0.0750759;
      _b[2] = 0.96900 * _b[2] + white * 0.1538520;
      _b[3] = 0.86650 * _b[3] + white * 0.3104856;
      _b[4] = 0.55000 * _b[4] + white * 0.5329522;
      _b[5] = -0.7616 * _b[5] - white * 0.0168980;
      buffer[i] = (_b[0] +
              _b[1] +
              _b[2] +
              _b[3] +
              _b[4] +
              _b[5] +
              _b[6] +
              white * 0.5362) *
          amplitude *
          0.11;
      _b[6] = white * 0.115926;
    }
    return _convertToInt16(buffer);
  }

  Uint8List _convertToInt16(Float64List buffer) {
    return Int16List.fromList(buffer.map((x) => (x * 32767).toInt()).toList())
        .buffer
        .asUint8List();
  }

  @override
  String get name => 'Pink Noise';
}
