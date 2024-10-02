import 'dart:typed_data';
import 'package:mesmerizr/core/audio_processor/audio_effects/audio_effect.dart';

import '../parameters/noise_generator_parameters.dart';

abstract class IAudioProcessor {
  Future<Uint8List> processAudio(
      NoiseGeneratorParameters parameters, int sampleRate, int bufferSize);
  void setVolume(double volume);
  void addEffect(AudioEffect effect);
  void removeEffect(AudioEffect effect);
  void clearEffects();
}
