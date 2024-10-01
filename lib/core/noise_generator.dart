import 'dart:typed_data';

abstract class NoiseGenerator {
  Uint8List generateNoise(int sampleRate, int bufferSize, double amplitude);
  String get name;
}
