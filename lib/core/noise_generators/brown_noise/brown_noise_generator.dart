import 'dart:math';
import 'dart:typed_data';
import '../../noise_generator.dart';

class BrownNoiseGenerator implements NoiseGenerator {
  final Random _random = Random();
  double _lastValue = 0.0;

  @override
  Uint8List generateNoise(int sampleRate, int bufferSize, double amplitude) {
    final buffer = Float64List(bufferSize);
    for (int i = 0; i < bufferSize; i++) {
      double white = _random.nextDouble() * 2 - 1;
      _lastValue = (_lastValue + (0.02 * white)) / 1.02;
      buffer[i] = _lastValue * amplitude * 3.5;
    }
    return _convertToInt16(buffer);
  }

  Uint8List _convertToInt16(Float64List buffer) {
    return Int16List.fromList(buffer.map((x) => (x * 32767).toInt()).toList())
        .buffer
        .asUint8List();
  }

  @override
  String get name => 'Brown Noise';
}
