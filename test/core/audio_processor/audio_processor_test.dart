import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mesmerizr/core/audio_processor/audio_processor.dart';
import 'package:mesmerizr/core/isolates/noise_isolate_processor.dart';
import 'package:mesmerizr/core/parameters/noise_generator_parameters.dart';
import 'package:mesmerizr/core/audio_processor/audio_effects/delay_effect.dart';

class MockNoiseIsolateProcessor extends Mock implements NoiseIsolateProcessor {}

class FakeNoiseGeneratorParameters extends Fake
    implements NoiseGeneratorParameters {}

void main() {
  late AudioProcessor audioProcessor;
  late MockNoiseIsolateProcessor mockNoiseProcessor;

  setUpAll(() {
    registerFallbackValue(FakeNoiseGeneratorParameters());
  });

  setUp(() {
    mockNoiseProcessor = MockNoiseIsolateProcessor();
    audioProcessor = AudioProcessor(mockNoiseProcessor);
  });

  test('processAudio should return correct length of Uint8List', () async {
    final parameters = NoiseGeneratorParameters(
      frequency: 440.0,
      amplitude: 0.5,
      lowPassCutoff: 20000.0,
      highPassCutoff: 20.0,
      smoothingFactor: 0.1,
      soundFrequencyLevel: 1.0,
      attackTime: 0.01,
      releaseTime: 0.01,
    );

    when(() => mockNoiseProcessor.generateNoise(any(), any(), any()))
        .thenAnswer((_) async => Uint8List.fromList(List.filled(1024, 128)));

    final result = await audioProcessor.processAudio(parameters, 44100, 1024);

    expect(result, isA<Uint8List>());
    expect(result.length, equals(1024));
  });

  test('setVolume should clamp volume between 0 and 1', () {
    audioProcessor.setVolume(1.5);
    expect(audioProcessor.volume, equals(1.0));

    audioProcessor.setVolume(-0.5);
    expect(audioProcessor.volume, equals(0.0));

    audioProcessor.setVolume(0.5);
    expect(audioProcessor.volume, equals(0.5));
  });

  test('_applyVolume should correctly scale samples', () {
    audioProcessor.setVolume(0.5);
    final input = Float64List.fromList([1.0, -1.0, 0.5, -0.5]);
    final result = audioProcessor.applyVolume(input);

    expect(result[0], closeTo(0.5, 0.001));
    expect(result[1], closeTo(-0.5, 0.001));
    expect(result[2], closeTo(0.25, 0.001));
    expect(result[3], closeTo(-0.25, 0.001));
  });

  test('addEffect and removeEffect should work correctly', () {
    final delayEffect = DelayEffect(delayTime: 0.1, feedback: 0.5);

    audioProcessor.addEffect(delayEffect);
    expect(audioProcessor.effects.length, equals(1));
    expect(audioProcessor.effects.first, equals(delayEffect));

    audioProcessor.removeEffect(delayEffect);
    expect(audioProcessor.effects.isEmpty, isTrue);
  });

  test('clearEffects should remove all effects', () {
    audioProcessor.addEffect(DelayEffect(delayTime: 0.1, feedback: 0.5));
    audioProcessor.addEffect(DelayEffect(delayTime: 0.2, feedback: 0.3));

    expect(audioProcessor.effects.length, equals(2));

    audioProcessor.clearEffects();
    expect(audioProcessor.effects.isEmpty, isTrue);
  });
}
