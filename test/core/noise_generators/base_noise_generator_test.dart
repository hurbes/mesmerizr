import 'package:flutter_test/flutter_test.dart';
import 'dart:typed_data';

import 'package:mesmerizr/core/noise_generators/base_noise_generator.dart';
import 'package:mesmerizr/core/parameters/noise_generator_parameters.dart';

class MockNoiseGenerator extends BaseNoiseGenerator {
  NoiseGeneratorParameters _parameters = NoiseGeneratorParameters(
    frequency: 440.0,
    amplitude: 0.5,
    lowPassCutoff: 20000.0,
    highPassCutoff: 20.0,
    smoothingFactor: 0.0,
    soundFrequencyLevel: 1.0,
  );

  @override
  String get name => 'Mock Noise';

  @override
  NoiseGeneratorParameters get parameters => _parameters;

  @override
  Float64List generateNoise(int sampleRate, int bufferSize) {
    return Float64List(bufferSize);
  }

  @override
  void updateParameters(NoiseGeneratorParameters newParameters) {
    _parameters = newParameters;
  }

  @override
  Float64List applyFilters(Float64List buffer, int sampleRate) {
    return buffer;
  }

  @override
  Uint8List convertToUint8(Float64List buffer) {
    return Uint8List(buffer.length);
  }
}

void main() {
  group('BaseNoiseGenerator', () {
    late MockNoiseGenerator mockGenerator;

    setUp(() {
      mockGenerator = MockNoiseGenerator();
    });

    test('name should return correct value', () {
      expect(mockGenerator.name, equals('Mock Noise'));
    });

    test('generateNoise should return Float64List of correct length', () {
      final result = mockGenerator.generateNoise(44100, 1024);
      expect(result, isA<Float64List>());
      expect(result.length, equals(1024));
    });

    test('applyFilters should return Float64List of correct length', () {
      final input = Float64List(1024);
      final result = mockGenerator.applyFilters(input, 44100);
      expect(result, isA<Float64List>());
      expect(result.length, equals(1024));
    });

    test('convertToUint8 should return Uint8List of correct length', () {
      final input = Float64List(1024);
      final result = mockGenerator.convertToUint8(input);
      expect(result, isA<Uint8List>());
      expect(result.length, equals(1024));
    });

    test('updateParameters should update parameters', () {
      final newParameters = NoiseGeneratorParameters(
        frequency: 880.0,
        amplitude: 0.75,
        lowPassCutoff: 15000.0,
        highPassCutoff: 50.0,
        smoothingFactor: 0.5,
        soundFrequencyLevel: 0.8,
      );
      mockGenerator.updateParameters(newParameters);
      expect(mockGenerator.parameters, equals(newParameters));
    });

    test('generateCompleteSample should return Uint8List of correct length',
        () {
      final result = mockGenerator.generateCompleteSample(44100, 1024);
      expect(result, isA<Uint8List>());
      expect(result.length, equals(1024));
    });
  });
}
