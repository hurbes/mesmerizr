import 'dart:typed_data';

class AudioFormatConverter {
  static Float64List uint8ToFloat64(Uint8List input) {
    return Float64List.fromList(input.map((e) => (e - 128) / 127).toList());
  }

  static Uint8List float64ToUint8(Float64List input) {
    return Uint8List.fromList(input
        .map((sample) => ((sample * 127) + 128).round().clamp(0, 255))
        .toList());
  }

  static Int16List float64ToInt16(Float64List input) {
    return Int16List.fromList(input
        .map((sample) => (sample * 32767).round().clamp(-32767, 32767))
        .toList());
  }

  static Float64List int16ToFloat64(Int16List input) {
    return Float64List.fromList(input.map((sample) => sample / 32767).toList());
  }
}
