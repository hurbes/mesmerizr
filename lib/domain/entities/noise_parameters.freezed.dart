// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'noise_parameters.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NoiseParameters _$NoiseParametersFromJson(Map<String, dynamic> json) {
  return _NoiseParameters.fromJson(json);
}

/// @nodoc
mixin _$NoiseParameters {
  double get frequency => throw _privateConstructorUsedError;
  double get amplitude => throw _privateConstructorUsedError;
  String get colorType => throw _privateConstructorUsedError;

  /// Serializes this NoiseParameters to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NoiseParameters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NoiseParametersCopyWith<NoiseParameters> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoiseParametersCopyWith<$Res> {
  factory $NoiseParametersCopyWith(
          NoiseParameters value, $Res Function(NoiseParameters) then) =
      _$NoiseParametersCopyWithImpl<$Res, NoiseParameters>;
  @useResult
  $Res call({double frequency, double amplitude, String colorType});
}

/// @nodoc
class _$NoiseParametersCopyWithImpl<$Res, $Val extends NoiseParameters>
    implements $NoiseParametersCopyWith<$Res> {
  _$NoiseParametersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NoiseParameters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frequency = null,
    Object? amplitude = null,
    Object? colorType = null,
  }) {
    return _then(_value.copyWith(
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as double,
      amplitude: null == amplitude
          ? _value.amplitude
          : amplitude // ignore: cast_nullable_to_non_nullable
              as double,
      colorType: null == colorType
          ? _value.colorType
          : colorType // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NoiseParametersImplCopyWith<$Res>
    implements $NoiseParametersCopyWith<$Res> {
  factory _$$NoiseParametersImplCopyWith(_$NoiseParametersImpl value,
          $Res Function(_$NoiseParametersImpl) then) =
      __$$NoiseParametersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double frequency, double amplitude, String colorType});
}

/// @nodoc
class __$$NoiseParametersImplCopyWithImpl<$Res>
    extends _$NoiseParametersCopyWithImpl<$Res, _$NoiseParametersImpl>
    implements _$$NoiseParametersImplCopyWith<$Res> {
  __$$NoiseParametersImplCopyWithImpl(
      _$NoiseParametersImpl _value, $Res Function(_$NoiseParametersImpl) _then)
      : super(_value, _then);

  /// Create a copy of NoiseParameters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frequency = null,
    Object? amplitude = null,
    Object? colorType = null,
  }) {
    return _then(_$NoiseParametersImpl(
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as double,
      amplitude: null == amplitude
          ? _value.amplitude
          : amplitude // ignore: cast_nullable_to_non_nullable
              as double,
      colorType: null == colorType
          ? _value.colorType
          : colorType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NoiseParametersImpl implements _NoiseParameters {
  const _$NoiseParametersImpl(
      {required this.frequency,
      required this.amplitude,
      required this.colorType});

  factory _$NoiseParametersImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoiseParametersImplFromJson(json);

  @override
  final double frequency;
  @override
  final double amplitude;
  @override
  final String colorType;

  @override
  String toString() {
    return 'NoiseParameters(frequency: $frequency, amplitude: $amplitude, colorType: $colorType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoiseParametersImpl &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.amplitude, amplitude) ||
                other.amplitude == amplitude) &&
            (identical(other.colorType, colorType) ||
                other.colorType == colorType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, frequency, amplitude, colorType);

  /// Create a copy of NoiseParameters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NoiseParametersImplCopyWith<_$NoiseParametersImpl> get copyWith =>
      __$$NoiseParametersImplCopyWithImpl<_$NoiseParametersImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NoiseParametersImplToJson(
      this,
    );
  }
}

abstract class _NoiseParameters implements NoiseParameters {
  const factory _NoiseParameters(
      {required final double frequency,
      required final double amplitude,
      required final String colorType}) = _$NoiseParametersImpl;

  factory _NoiseParameters.fromJson(Map<String, dynamic> json) =
      _$NoiseParametersImpl.fromJson;

  @override
  double get frequency;
  @override
  double get amplitude;
  @override
  String get colorType;

  /// Create a copy of NoiseParameters
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NoiseParametersImplCopyWith<_$NoiseParametersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
