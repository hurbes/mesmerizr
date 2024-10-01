import 'dart:math';
import 'dart:typed_data';
import '../../noise_generator.dart';

class WhiteNoiseGenerator implements NoiseGenerator {
  final Random _random = Random();

  @override
  Uint8List generateNoise(int sampleRate, int bufferSize, double amplitude) {
    final buffer = Float64List(bufferSize);
    for (int i = 0; i < bufferSize; i++) {
      buffer[i] = (_random.nextDouble() * 2 - 1) * amplitude;
    }
    return _convertToInt16(buffer);
  }

  Uint8List _convertToInt16(Float64List buffer) {
    return Int16List.fromList(buffer.map((x) => (x * 32767).toInt()).toList())
        .buffer
        .asUint8List();
  }

  @override
  String get name => 'White Noise';
}
