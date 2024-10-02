import 'dart:async';
import 'dart:typed_data';
import '../interfaces/audio_processor.dart';
import '../interfaces/logger.dart';
import '../parameters/noise_generator_parameters.dart';
import '../audio_processor/audio_effects/audio_effect.dart';
import '../isolates/noise_isolate_processor.dart';
import '../audio_processor/audio_processor.dart';
import '../logger/concrete_logger.dart';

class AppProcessor {
  late final IAudioProcessor _audioProcessor;
  late final ILogger _logger;
  final StreamController<Uint8List> _audioStreamController =
      StreamController<Uint8List>.broadcast();

  AppProcessor() {
    _initializeProcessors();
  }

  void _initializeProcessors() {
    final noiseProcessor = NoiseIsolateProcessor();
    _audioProcessor = AudioProcessor(noiseProcessor);
    _logger = ConcreteLogger();
  }

  Stream<Uint8List> get audioStream => _audioStreamController.stream;

  Future<void> generateAndProcessAudio(NoiseGeneratorParameters parameters,
      int sampleRate, int bufferSize) async {
    try {
      final processedAudio = await _audioProcessor.processAudio(
          parameters, sampleRate, bufferSize);
      _audioStreamController.add(processedAudio);
      _logger.log('Audio processed successfully');
    } catch (e) {
      _logger.error('Error processing audio: $e');
    }
  }

  void setVolume(double volume) {
    _audioProcessor.setVolume(volume);
    _logger.log('Volume set to: $volume');
  }

  void addEffect(AudioEffect effect) {
    _audioProcessor.addEffect(effect);
    _logger.log('Effect added: ${effect.name}');
  }

  void removeEffect(AudioEffect effect) {
    _audioProcessor.removeEffect(effect);
    _logger.log('Effect removed: ${effect.name}');
  }

  void clearEffects() {
    _audioProcessor.clearEffects();
    _logger.log('All effects cleared');
  }

  void dispose() {
    _audioStreamController.close();
    _logger.log('AppProcessor disposed');
  }
}
