import 'package:freezed_annotation/freezed_annotation.dart';

part 'noise_generator_parameters.freezed.dart';

@freezed
class NoiseGeneratorParameters with _$NoiseGeneratorParameters {
  const factory NoiseGeneratorParameters({
    required double frequency,
    required double amplitude,
    required double lowPassCutoff,
    required double highPassCutoff,
    required double smoothingFactor,
  }) = _NoiseGeneratorParameters;
}
