import 'dart:typed_data';
import '../interfaces/audio_processor.dart';
import '../parameters/noise_generator_parameters.dart';
import '../isolates/noise_isolate_processor.dart';
import 'audio_format_converter.dart';
import 'audio_effects/audio_effect.dart';

class AudioProcessor implements IAudioProcessor {
  final NoiseIsolateProcessor _noiseProcessor;
  double _volume = 1.0;
  final List<AudioEffect> _effects = [];

  AudioProcessor(this._noiseProcessor);

  @override
  Future<Uint8List> processAudio(NoiseGeneratorParameters parameters,
      int sampleRate, int bufferSize) async {
    Uint8List rawNoise =
        await _noiseProcessor.generateNoise(parameters, sampleRate, bufferSize);
    Float64List floatSamples = AudioFormatConverter.uint8ToFloat64(rawNoise);

    floatSamples = _applyVolume(floatSamples);
    floatSamples = _applyEffects(floatSamples, sampleRate);

    return AudioFormatConverter.float64ToUint8(floatSamples);
  }

  @override
  void setVolume(double volume) {
    _volume = volume.clamp(0.0, 1.0);
  }

  double get volume => _volume;

  @override
  void addEffect(AudioEffect effect) {
    _effects.add(effect);
  }

  @override
  void removeEffect(AudioEffect effect) {
    _effects.remove(effect);
  }

  @override
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

  List<AudioEffect> get effects => List.unmodifiable(_effects);

  Float64List applyVolume(Float64List input) => _applyVolume(input);
}
