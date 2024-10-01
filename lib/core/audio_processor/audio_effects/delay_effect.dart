import 'dart:typed_data';
import 'audio_effect.dart';

class DelayEffect extends AudioEffect {
  final double _delayTime;
  final double _feedback;

  DelayEffect({required double delayTime, required double feedback})
      : _delayTime = delayTime,
        _feedback = feedback.clamp(0.0, 1.0);

  @override
  String get name => 'Delay';

  @override
  Float64List apply(Float64List input, int sampleRate) {
    final delaySamples = (_delayTime * sampleRate).round();
    final output = Float64List(input.length);

    for (int i = 0; i < input.length; i++) {
      output[i] = input[i];
      if (i >= delaySamples) {
        output[i] += input[i - delaySamples] * _feedback;
      }
    }

    return output;
  }
}
