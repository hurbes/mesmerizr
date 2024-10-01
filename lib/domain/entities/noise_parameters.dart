import 'package:freezed_annotation/freezed_annotation.dart';

part 'noise_parameters.freezed.dart';
part 'noise_parameters.g.dart';

@freezed
class NoiseParameters with _$NoiseParameters {
  const factory NoiseParameters({
    required double frequency,
    required double amplitude,
    required String colorType,
  }) = _NoiseParameters;

  factory NoiseParameters.fromJson(Map<String, dynamic> json) =>
      _$NoiseParametersFromJson(json);
}
