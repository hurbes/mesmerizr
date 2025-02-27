import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.audioFailure() = AudioFailure;
  const factory Failure.shaderFailure() = ShaderFailure;
}
