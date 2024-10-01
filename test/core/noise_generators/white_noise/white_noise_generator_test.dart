import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:mesmerizr/core/noise_generators/white_noise/white_noise_generator.dart';
import 'package:mesmerizr/core/parameters/noise_generator_parameters.dart';

void main() {
  group('WhiteNoiseGenerator', () {
    late WhiteNoiseGenerator whiteNoiseGenerator;

    setUp(() {
      whiteNoiseGenerator = WhiteNoiseGenerator(
        NoiseGeneratorParameters(
          frequency: 440.0,
          amplitude: 0.5,
          lowPassCutoff: 20000.0,
          highPassCutoff: 20.0,
          smoothingFactor: 0.1,
          soundFrequencyLevel: 1.0,
          attackTime: 0.01,
          releaseTime: 0.01,
        ),
      );
    });

    test('name should return "White Noise"', () {
      expect(whiteNoiseGenerator.name, equals('White Noise'));
    });

    test('generateNoise should return Float64List of correct length', () {
      final result = whiteNoiseGenerator.generateNoise(44100, 1024);
      expect(result, isA<Float64List>());
      expect(result.length, equals(1024));
    });

    test('generateNoise should produce values within amplitude range', () {
      final result = whiteNoiseGenerator.generateNoise(44100, 1024);
      for (var sample in result) {
        expect(sample, inInclusiveRange(-0.5, 0.5));
      }
    });

    test('applyFilters should return Float64List of correct length', () {
      final input = Float64List.fromList(List.filled(1024, 0.5));
      final result = whiteNoiseGenerator.applyFilters(input, 44100);
      expect(result, isA<Float64List>());
      expect(result.length, equals(1024));
    });

    test('convertToUint8 should return Uint8List of correct length', () {
      final input = Float64List.fromList(List.filled(1024, 0.5));
      final result = whiteNoiseGenerator.convertToUint8(input);
      expect(result, isA<Uint8List>());
      expect(result.length,
          equals(1024 * 2)); // 2 bytes per sample for 16-bit audio
    });

    test('updateParameters should update parameters', () {
      final newParameters = NoiseGeneratorParameters(
        frequency: 880.0,
        amplitude: 0.75,
        lowPassCutoff: 15000.0,
        highPassCutoff: 50.0,
        smoothingFactor: 0.2,
        soundFrequencyLevel: 0.8,
        attackTime: 0.02,
        releaseTime: 0.02,
      );
      whiteNoiseGenerator.updateParameters(newParameters);
      expect(whiteNoiseGenerator.parameters, equals(newParameters));
    });

    test('generateCompleteSample should return Uint8List of correct length',
        () {
      final result = whiteNoiseGenerator.generateCompleteSample(44100, 1024);
      expect(result, isA<Uint8List>());
      expect(result.length,
          equals(1024 * 2)); // 2 bytes per sample for 16-bit audio
    });

    test('generateNoise should apply volume envelope', () {
      final result = whiteNoiseGenerator.generateNoise(44100, 1024);
      expect(result[0], closeTo(0, 0.01)); // Start of attack
      expect(result[1023], closeTo(0, 0.01)); // End of release
    });
  });
}
