import 'dart:typed_data';

abstract class AudioEffect {
  String get name;
  Float64List apply(Float64List input, int sampleRate);
}
