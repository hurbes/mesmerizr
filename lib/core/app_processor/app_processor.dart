import 'dart:async';
import 'dart:typed_data';
import 'package:mesmerizr/core/noise_generators/white_noise/white_noise_generator.dart';

import '../interfaces/logger.dart';
import '../parameters/noise_generator_parameters.dart';
import '../audio_processor/audio_effects/audio_effect.dart';
import '../noise_processor/noise_processor.dart';
import '../audio_processor/audio_processor.dart';
import '../logger/concrete_logger.dart';
import '../isolate_processor/isolate_processor.dart';

class AppProcessor {
  late final AudioProcessor _audioProcessor;
  late final NoiseProcessor _noiseProcessor;
  late final ILogger _logger;
  final StreamController<Uint8List> _audioStreamController =
      StreamController<Uint8List>.broadcast();

  AppProcessor() {
    _initializeProcessors();
  }

  void _initializeProcessors() {
    _logger = ConcreteLogger();

    // Initialize WhiteNoiseGenerator with sleep-optimized parameters
    final sleepOptimizedParameters = NoiseGeneratorParameters(
      frequency: 440, // A4 note frequency
      amplitude: 0.7, // Slightly reduced amplitude for comfort
      // Add any other relevant parameters for sleep optimization
      lowPassCutoff: 1000,
      highPassCutoff: 1000,
      smoothingFactor: 0.5,
      soundFrequencyLevel: 0.5,
      attackTime: 0.1,
      releaseTime: 0.1,
    );
    final whiteNoiseGenerator = WhiteNoiseGenerator(sleepOptimizedParameters);

    final isolateProcessor = IsolateProcessor();
    _noiseProcessor = NoiseProcessor(whiteNoiseGenerator, isolateProcessor);

    // Initialize AudioProcessor with NoiseProcessor
    _audioProcessor = AudioProcessor(_noiseProcessor);
  }

  Future<void> initialize() async {
    await _noiseProcessor.initialize();
    _logger.log('AppProcessor initialized successfully');
  }

  Stream<Uint8List> get audioStream => _audioStreamController.stream;

  Future<void> startGeneratingNoise() async {
    await _noiseProcessor.startGeneratingNoise();
    _logger.log('White noise generation started');
  }

  Future<void> stopGeneratingNoise() async {
    await _noiseProcessor.stopGeneratingNoise();
    _logger.log('White noise generation stopped');
  }

  Future<void> updateNoiseParameters(
      NoiseGeneratorParameters parameters) async {
    await _noiseProcessor.updateNoiseParameters(parameters);
    _logger.log('White noise parameters updated');
  }

  Future<Uint8List> processAudio(int sampleRate, int bufferSize) async {
    try {
      final processedAudio =
          await _noiseProcessor.processNoise(sampleRate, bufferSize);
      _audioStreamController.add(processedAudio);
      _logger.log('White noise audio processed successfully');
      return processedAudio;
    } catch (e) {
      _logger.error('Error processing white noise audio: $e');
      rethrow;
    }
  }

  void setVolume(double volume) {
    _audioProcessor.setVolume(volume);
    _logger.log('White noise volume set to: $volume');
  }

  void addEffect(AudioEffect effect) {
    _audioProcessor.addEffect(effect);
    _logger.log('Effect added to white noise: ${effect.runtimeType}');
  }

  void removeEffect(AudioEffect effect) {
    _audioProcessor.removeEffect(effect);
    _logger.log('Effect removed from white noise: ${effect.runtimeType}');
  }

  void clearEffects() {
    _audioProcessor.clearEffects();
    _logger.log('All effects cleared from white noise');
  }

  Future<void> dispose() async {
    await _audioStreamController.close();
    await _noiseProcessor.dispose();
    _logger.log('AppProcessor disposed');
  }

  bool get isNoiseGenerating => _noiseProcessor.isGenerating;
  bool get isInitialized => _noiseProcessor.isInitialized;
}
