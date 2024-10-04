import 'dart:async';
import 'dart:typed_data';
import 'package:mesmerizr/core/noise_processor/noise_processor.dart';
import 'package:mesmerizr/core/parameters/noise_generator_parameters.dart';
import 'package:mesmerizr/core/audio_processor/audio_effects/audio_effect.dart';

class AudioProcessor {
  final NoiseProcessor _noiseProcessor;
  final StreamController<Uint8List> _processedAudioController =
      StreamController<Uint8List>.broadcast();

  double _volume = 1.0;
  bool _isPlaying = false;
  double _pan = 0.0; // -1.0 (left) to 1.0 (right)
  List<AudioEffect> _effects = [];

  AudioProcessor(this._noiseProcessor);

  Stream<Uint8List> get processedAudioStream =>
      _processedAudioController.stream;

  Future<void> initialize() async {
    await _noiseProcessor.initialize();
    _noiseProcessor.noiseStream.listen(_processAudio);
  }

  void _processAudio(Uint8List rawAudio) {
    Float64List floatData = Float64List.view(rawAudio.buffer);
    floatData = _applyVolume(floatData);
    floatData = _applyPan(floatData);
    floatData = _applyEffects(floatData);
    _processedAudioController.add(floatData.buffer.asUint8List());
  }

  Float64List _applyVolume(Float64List audio) {
    if (_volume == 1.0) return audio;
    return Float64List.fromList(
        audio.map((sample) => sample * _volume).toList());
  }

  Float64List _applyPan(Float64List audio) {
    if (_pan == 0.0) return audio;
    final leftGain = 1.0 - _pan.clamp(-1.0, 1.0);
    final rightGain = 1.0 + _pan.clamp(-1.0, 1.0);
    for (int i = 0; i < audio.length; i += 2) {
      audio[i] *= leftGain;
      if (i + 1 < audio.length) {
        audio[i + 1] *= rightGain;
      }
    }
    return audio;
  }

  Float64List _applyEffects(Float64List audio) {
    for (var effect in _effects) {
      audio = effect.apply(audio);
    }
    return audio;
  }

  Future<void> play() async {
    if (!_isPlaying) {
      await _noiseProcessor.startGeneratingNoise();
      _isPlaying = true;
    }
  }

  Future<void> stop() async {
    if (_isPlaying) {
      await _noiseProcessor.stopGeneratingNoise();
      _isPlaying = false;
    }
  }

  void setVolume(double volume) {
    _volume = volume.clamp(0.0, 1.0);
  }

  void setPan(double pan) {
    _pan = pan.clamp(-1.0, 1.0);
  }

  void addEffect(AudioEffect effect) {
    _effects.add(effect);
  }

  void removeEffect(AudioEffect effect) {
    _effects.remove(effect);
  }

  void clearEffects() {
    _effects.clear();
  }

  Future<void> updateNoiseParameters(
      NoiseGeneratorParameters parameters) async {
    await _noiseProcessor.updateNoiseParameters(parameters);
  }

  Future<void> dispose() async {
    await stop();
    await _processedAudioController.close();
    await _noiseProcessor.dispose();
  }

  bool get isPlaying => _isPlaying;
  double get volume => _volume;
  double get pan => _pan;
  List<AudioEffect> get effects => List.unmodifiable(_effects);
}
