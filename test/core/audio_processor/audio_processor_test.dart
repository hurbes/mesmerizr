import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:mesmerizr/core/audio_processor/audio_processor.dart';
import 'package:mesmerizr/core/noise_processor/noise_processor.dart';
import 'package:mesmerizr/core/parameters/noise_generator_parameters.dart';
import 'package:mesmerizr/core/audio_processor/audio_effects/audio_effect.dart';
import 'dart:typed_data';

@GenerateMocks([NoiseProcessor])
import 'audio_processor_test.mocks.dart';

class MockAudioEffect extends Mock implements AudioEffect {}

void main() {
  late AudioProcessor audioProcessor;
  late MockNoiseProcessor mockNoiseProcessor;

  setUp(() {
    mockNoiseProcessor = MockNoiseProcessor();
    audioProcessor = AudioProcessor(mockNoiseProcessor);
  });

  test('initialize should set up the audio processor correctly', () async {
    when(mockNoiseProcessor.initialize()).thenAnswer((_) async {});
    when(mockNoiseProcessor.noiseStream).thenAnswer((_) => Stream.empty());

    await audioProcessor.initialize();

    verify(mockNoiseProcessor.initialize()).called(1);
    verify(mockNoiseProcessor.noiseStream).called(1);
  });

  test('play should start generating noise', () async {
    when(mockNoiseProcessor.startGeneratingNoise()).thenAnswer((_) async {});

    await audioProcessor.play();

    expect(audioProcessor.isPlaying, true);
    verify(mockNoiseProcessor.startGeneratingNoise()).called(1);
  });

  test('stop should stop generating noise', () async {
    when(mockNoiseProcessor.startGeneratingNoise()).thenAnswer((_) async {});
    when(mockNoiseProcessor.stopGeneratingNoise()).thenAnswer((_) async {});

    await audioProcessor.play();
    await audioProcessor.stop();

    expect(audioProcessor.isPlaying, false);
    verify(mockNoiseProcessor.stopGeneratingNoise()).called(1);
  });

  test('setVolume should update volume correctly', () {
    audioProcessor.setVolume(0.5);
    expect(audioProcessor.volume, 0.5);

    audioProcessor.setVolume(1.5);
    expect(audioProcessor.volume, 1.0);

    audioProcessor.setVolume(-0.5);
    expect(audioProcessor.volume, 0.0);
  });

  test('setPan should update pan correctly', () {
    audioProcessor.setPan(0.5);
    expect(audioProcessor.pan, 0.5);

    audioProcessor.setPan(1.5);
    expect(audioProcessor.pan, 1.0);

    audioProcessor.setPan(-1.5);
    expect(audioProcessor.pan, -1.0);
  });

  test('addEffect and removeEffect should manage effects correctly', () {
    final effect1 = MockAudioEffect();
    final effect2 = MockAudioEffect();

    audioProcessor.addEffect(effect1);
    expect(audioProcessor.effects.length, 1);
    expect(audioProcessor.effects.first, effect1);

    audioProcessor.addEffect(effect2);
    expect(audioProcessor.effects.length, 2);

    audioProcessor.removeEffect(effect1);
    expect(audioProcessor.effects.length, 1);
    expect(audioProcessor.effects.first, effect2);

    audioProcessor.clearEffects();
    expect(audioProcessor.effects.isEmpty, true);
  });

  test('updateNoiseParameters should update noise generator parameters',
      () async {
    final parameters = NoiseGeneratorParameters(
      frequency: 440,
      amplitude: 0.5,
      lowPassCutoff: 1000,
      highPassCutoff: 2000,
      smoothingFactor: 0.1,
      soundFrequencyLevel: 0.5,
      attackTime: 0.1,
      releaseTime: 0.1,
    );
    when(mockNoiseProcessor.updateNoiseParameters(parameters))
        .thenAnswer((_) async {});

    await audioProcessor.updateNoiseParameters(parameters);

    verify(mockNoiseProcessor.updateNoiseParameters(parameters)).called(1);
  });

  test('dispose should clean up resources', () async {
    when(mockNoiseProcessor.stopGeneratingNoise()).thenAnswer((_) async {});
    when(mockNoiseProcessor.dispose()).thenAnswer((_) async {});

    await audioProcessor.dispose();

    verify(mockNoiseProcessor.stopGeneratingNoise()).called(1);
    verify(mockNoiseProcessor.dispose()).called(1);
  });

  test('processedAudioStream should emit processed audio', () async {
    final rawAudio =
        Float64List.fromList([0.5, -0.5, 0.25, -0.25]).buffer.asUint8List();

    when(mockNoiseProcessor.initialize()).thenAnswer((_) async {});
    when(mockNoiseProcessor.noiseStream)
        .thenAnswer((_) => Stream.fromIterable([rawAudio]));

    await audioProcessor.initialize();
    audioProcessor.setVolume(0.5);

    audioProcessor.processedAudioStream.listen(expectAsync1((processedAudio) {
      final processedFloat = Float64List.view(processedAudio.buffer);
      expect(processedFloat, [0.25, -0.25, 0.125, -0.125]);
    }));
  });
}
