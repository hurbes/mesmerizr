import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:mesmerizr/core/noise_processor/noise_processor.dart';
import 'package:mesmerizr/core/noise_generators/base_noise_generator.dart';
import 'package:mesmerizr/core/isolate_processor/isolate_processor.dart';
import 'package:mesmerizr/core/parameters/noise_generator_parameters.dart';

@GenerateMocks([BaseNoiseGenerator, IsolateProcessor])
import 'noise_processor_test.mocks.dart';

void main() {
  late NoiseProcessor noiseProcessor;
  late MockBaseNoiseGenerator mockNoiseGenerator;
  late MockIsolateProcessor mockIsolateProcessor;

  setUp(() {
    mockNoiseGenerator = MockBaseNoiseGenerator();
    mockIsolateProcessor = MockIsolateProcessor();
    noiseProcessor = NoiseProcessor(mockNoiseGenerator, mockIsolateProcessor);
  });

  test('initialize should set up the noise processor correctly', () async {
    when(mockIsolateProcessor.initialize()).thenAnswer((_) async {});

    await noiseProcessor.initialize();

    expect(noiseProcessor.isInitialized, true);
    verify(mockIsolateProcessor.initialize()).called(1);
  });

  test('startGeneratingNoise should start the noise generation process',
      () async {
    when(mockIsolateProcessor.initialize()).thenAnswer((_) async {});
    when(mockIsolateProcessor.start(any)).thenAnswer((_) async {});
    when(mockIsolateProcessor.listen(any)).thenAnswer((_) async {});

    await noiseProcessor.initialize();
    await noiseProcessor.startGeneratingNoise();

    expect(noiseProcessor.isGenerating, true);
    verify(mockIsolateProcessor.start(any)).called(1);
    verify(mockIsolateProcessor.listen(any)).called(1);
  });

  test('stopGeneratingNoise should stop the noise generation process',
      () async {
    when(mockIsolateProcessor.initialize()).thenAnswer((_) async {});
    when(mockIsolateProcessor.start(any)).thenAnswer((_) async {});
    when(mockIsolateProcessor.stop()).thenAnswer((_) async {});

    await noiseProcessor.initialize();
    await noiseProcessor.startGeneratingNoise();
    await noiseProcessor.stopGeneratingNoise();

    expect(noiseProcessor.isGenerating, false);
    verify(mockIsolateProcessor.stop()).called(1);
  });

  test('updateNoiseParameters should update the noise generator parameters',
      () async {
    when(mockIsolateProcessor.initialize()).thenAnswer((_) async {});
    when(mockIsolateProcessor.start(any)).thenAnswer((_) async {});
    when(mockIsolateProcessor.send(any)).thenAnswer((_) async {});

    await noiseProcessor.initialize();
    await noiseProcessor.startGeneratingNoise();

    final newParameters = NoiseGeneratorParameters(
        frequency: 440,
        amplitude: 0.5,
        lowPassCutoff: 1000,
        highPassCutoff: 2000,
        smoothingFactor: 0.1,
        soundFrequencyLevel: 0.5,
        attackTime: 0.1,
        releaseTime: 0.1);
    await noiseProcessor.updateNoiseParameters(newParameters);

    verify(mockNoiseGenerator.updateParameters(newParameters)).called(1);
    verify(mockIsolateProcessor.send(mockNoiseGenerator)).called(1);
  });

  test('dispose should clean up resources', () async {
    when(mockIsolateProcessor.initialize()).thenAnswer((_) async {});
    when(mockIsolateProcessor.start(any)).thenAnswer((_) async {});
    when(mockIsolateProcessor.stop()).thenAnswer((_) async {});
    when(mockIsolateProcessor.dispose()).thenAnswer((_) async {});

    await noiseProcessor.initialize();
    await noiseProcessor.startGeneratingNoise();
    await noiseProcessor.dispose();

    expect(noiseProcessor.isInitialized, false);
    verify(mockIsolateProcessor.stop()).called(1);
    verify(mockIsolateProcessor.dispose()).called(1);
  });

  test('startGeneratingNoise should not start if already generating', () async {
    when(mockIsolateProcessor.initialize()).thenAnswer((_) async {});
    when(mockIsolateProcessor.start(any)).thenAnswer((_) async {});

    await noiseProcessor.initialize();
    await noiseProcessor.startGeneratingNoise();
    await noiseProcessor.startGeneratingNoise();

    verify(mockIsolateProcessor.start(any)).called(1);
  });

  test('stopGeneratingNoise should not stop if not generating', () async {
    when(mockIsolateProcessor.initialize()).thenAnswer((_) async {});
    when(mockIsolateProcessor.stop()).thenAnswer((_) async {});

    await noiseProcessor.initialize();
    await noiseProcessor.stopGeneratingNoise();

    verifyNever(mockIsolateProcessor.stop());
  });
}
