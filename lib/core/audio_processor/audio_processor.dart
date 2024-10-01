import 'dart:typed_data';
import '../parameters/noise_generator_parameters.dart';
import '../isolates/noise_isolate_processor.dart';
import 'audio_format_converter.dart';
import 'audio_effects/audio_effect.dart';

class AudioProcessor {
  final NoiseIsolateProcessor _noiseProcessor;
  double _volume = 1.0;
  final List<AudioEffect> _effects = [];

  AudioProcessor(this._noiseProcessor);

  Future<Uint8List> processAudio(NoiseGeneratorParameters parameters,
      int sampleRate, int bufferSize) async {
    Uint8List rawNoise =
        await _noiseProcessor.generateNoise(parameters, sampleRate, bufferSize);
    Float64List floatSamples = AudioFormatConverter.uint8ToFloat64(rawNoise);

    floatSamples = _applyVolume(floatSamples);
    floatSamples = _applyEffects(floatSamples, sampleRate);

    return AudioFormatConverter.float64ToUint8(floatSamples);
  }

  void setVolume(double volume) {
    _volume = volume.clamp(0.0, 1.0);
  }

  double get volume => _volume;

  void addEffect(AudioEffect effect) {
    _effects.add(effect);
  }

  void removeEffect(AudioEffect effect) {
    _effects.remove(effect);
  }

  void clearEffects() {
    _effects.clear();
  }

  Float64List _applyVolume(Float64List input) {
    return Float64List.fromList(
        input.map((sample) => sample * _volume).toList());
  }

  Float64List _applyEffects(Float64List input, int sampleRate) {
    Float64List result = input;
    for (var effect in _effects) {
      result = effect.apply(result, sampleRate);
    }
    return result;
  }

  // Expose effects list for testing
  List<AudioEffect> get effects => List.unmodifiable(_effects);

  // Expose applyVolume method for testing
  Float64List applyVolume(Float64List input) => _applyVolume(input);
}
