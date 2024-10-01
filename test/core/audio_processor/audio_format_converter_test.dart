import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:mesmerizr/core/audio_processor/audio_format_converter.dart';

void main() {
  group('AudioFormatConverter', () {
    test('uint8ToFloat64 should convert correctly', () {
      final input = Uint8List.fromList([0, 128, 255]);
      final result = AudioFormatConverter.uint8ToFloat64(input);
      expect(result[0], closeTo(-1.0, 0.01));
      expect(result[1], closeTo(0.0, 0.01));
      expect(result[2], closeTo(1.0, 0.01));
    });

    test('float64ToUint8 should convert correctly', () {
      final input = Float64List.fromList([-1.0, 0.0, 1.0]);
      final result = AudioFormatConverter.float64ToUint8(input);
      expect(result[0], equals(1));
      expect(result[1], equals(128));
      expect(result[2], equals(255));
    });

    test('float64ToInt16 should convert correctly', () {
      final input = Float64List.fromList([-1.0, 0.0, 1.0]);
      final result = AudioFormatConverter.float64ToInt16(input);
      expect(result[0], equals(-32767));
      expect(result[1], equals(0));
      expect(result[2], equals(32767));
    });

    test('int16ToFloat64 should convert correctly', () {
      final input = Int16List.fromList([-32767, 0, 32767]);
      final result = AudioFormatConverter.int16ToFloat64(input);
      expect(result[0], closeTo(-1.0, 0.0001));
      expect(result[1], closeTo(0.0, 0.0001));
      expect(result[2], closeTo(1.0, 0.0001));
    });
  });
}
