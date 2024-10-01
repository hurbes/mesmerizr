// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'noise_generator_parameters.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NoiseGeneratorParameters {
  double get frequency => throw _privateConstructorUsedError;
  double get amplitude => throw _privateConstructorUsedError;
  double get lowPassCutoff => throw _privateConstructorUsedError;
  double get highPassCutoff => throw _privateConstructorUsedError;
  double get smoothingFactor => throw _privateConstructorUsedError;
  double get soundFrequencyLevel => throw _privateConstructorUsedError;

  /// Create a copy of NoiseGeneratorParameters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NoiseGeneratorParametersCopyWith<NoiseGeneratorParameters> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoiseGeneratorParametersCopyWith<$Res> {
  factory $NoiseGeneratorParametersCopyWith(NoiseGeneratorParameters value,
          $Res Function(NoiseGeneratorParameters) then) =
      _$NoiseGeneratorParametersCopyWithImpl<$Res, NoiseGeneratorParameters>;
  @useResult
  $Res call(
      {double frequency,
      double amplitude,
      double lowPassCutoff,
      double highPassCutoff,
      double smoothingFactor,
      double soundFrequencyLevel});
}

/// @nodoc
class _$NoiseGeneratorParametersCopyWithImpl<$Res,
        $Val extends NoiseGeneratorParameters>
    implements $NoiseGeneratorParametersCopyWith<$Res> {
  _$NoiseGeneratorParametersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NoiseGeneratorParameters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frequency = null,
    Object? amplitude = null,
    Object? lowPassCutoff = null,
    Object? highPassCutoff = null,
    Object? smoothingFactor = null,
    Object? soundFrequencyLevel = null,
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
      lowPassCutoff: null == lowPassCutoff
          ? _value.lowPassCutoff
          : lowPassCutoff // ignore: cast_nullable_to_non_nullable
              as double,
      highPassCutoff: null == highPassCutoff
          ? _value.highPassCutoff
          : highPassCutoff // ignore: cast_nullable_to_non_nullable
              as double,
      smoothingFactor: null == smoothingFactor
          ? _value.smoothingFactor
          : smoothingFactor // ignore: cast_nullable_to_non_nullable
              as double,
      soundFrequencyLevel: null == soundFrequencyLevel
          ? _value.soundFrequencyLevel
          : soundFrequencyLevel // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NoiseGeneratorParametersImplCopyWith<$Res>
    implements $NoiseGeneratorParametersCopyWith<$Res> {
  factory _$$NoiseGeneratorParametersImplCopyWith(
          _$NoiseGeneratorParametersImpl value,
          $Res Function(_$NoiseGeneratorParametersImpl) then) =
      __$$NoiseGeneratorParametersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double frequency,
      double amplitude,
      double lowPassCutoff,
      double highPassCutoff,
      double smoothingFactor,
      double soundFrequencyLevel});
}

/// @nodoc
class __$$NoiseGeneratorParametersImplCopyWithImpl<$Res>
    extends _$NoiseGeneratorParametersCopyWithImpl<$Res,
        _$NoiseGeneratorParametersImpl>
    implements _$$NoiseGeneratorParametersImplCopyWith<$Res> {
  __$$NoiseGeneratorParametersImplCopyWithImpl(
      _$NoiseGeneratorParametersImpl _value,
      $Res Function(_$NoiseGeneratorParametersImpl) _then)
      : super(_value, _then);

  /// Create a copy of NoiseGeneratorParameters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frequency = null,
    Object? amplitude = null,
    Object? lowPassCutoff = null,
    Object? highPassCutoff = null,
    Object? smoothingFactor = null,
    Object? soundFrequencyLevel = null,
  }) {
    return _then(_$NoiseGeneratorParametersImpl(
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as double,
      amplitude: null == amplitude
          ? _value.amplitude
          : amplitude // ignore: cast_nullable_to_non_nullable
              as double,
      lowPassCutoff: null == lowPassCutoff
          ? _value.lowPassCutoff
          : lowPassCutoff // ignore: cast_nullable_to_non_nullable
              as double,
      highPassCutoff: null == highPassCutoff
          ? _value.highPassCutoff
          : highPassCutoff // ignore: cast_nullable_to_non_nullable
              as double,
      smoothingFactor: null == smoothingFactor
          ? _value.smoothingFactor
          : smoothingFactor // ignore: cast_nullable_to_non_nullable
              as double,
      soundFrequencyLevel: null == soundFrequencyLevel
          ? _value.soundFrequencyLevel
          : soundFrequencyLevel // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$NoiseGeneratorParametersImpl implements _NoiseGeneratorParameters {
  const _$NoiseGeneratorParametersImpl(
      {required this.frequency,
      required this.amplitude,
      required this.lowPassCutoff,
      required this.highPassCutoff,
      required this.smoothingFactor,
      required this.soundFrequencyLevel});

  @override
  final double frequency;
  @override
  final double amplitude;
  @override
  final double lowPassCutoff;
  @override
  final double highPassCutoff;
  @override
  final double smoothingFactor;
  @override
  final double soundFrequencyLevel;

  @override
  String toString() {
    return 'NoiseGeneratorParameters(frequency: $frequency, amplitude: $amplitude, lowPassCutoff: $lowPassCutoff, highPassCutoff: $highPassCutoff, smoothingFactor: $smoothingFactor, soundFrequencyLevel: $soundFrequencyLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoiseGeneratorParametersImpl &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.amplitude, amplitude) ||
                other.amplitude == amplitude) &&
            (identical(other.lowPassCutoff, lowPassCutoff) ||
                other.lowPassCutoff == lowPassCutoff) &&
            (identical(other.highPassCutoff, highPassCutoff) ||
                other.highPassCutoff == highPassCutoff) &&
            (identical(other.smoothingFactor, smoothingFactor) ||
                other.smoothingFactor == smoothingFactor) &&
            (identical(other.soundFrequencyLevel, soundFrequencyLevel) ||
                other.soundFrequencyLevel == soundFrequencyLevel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, frequency, amplitude,
      lowPassCutoff, highPassCutoff, smoothingFactor, soundFrequencyLevel);

  /// Create a copy of NoiseGeneratorParameters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NoiseGeneratorParametersImplCopyWith<_$NoiseGeneratorParametersImpl>
      get copyWith => __$$NoiseGeneratorParametersImplCopyWithImpl<
          _$NoiseGeneratorParametersImpl>(this, _$identity);
}

abstract class _NoiseGeneratorParameters implements NoiseGeneratorParameters {
  const factory _NoiseGeneratorParameters(
          {required final double frequency,
          required final double amplitude,
          required final double lowPassCutoff,
          required final double highPassCutoff,
          required final double smoothingFactor,
          required final double soundFrequencyLevel}) =
      _$NoiseGeneratorParametersImpl;

  @override
  double get frequency;
  @override
  double get amplitude;
  @override
  double get lowPassCutoff;
  @override
  double get highPassCutoff;
  @override
  double get smoothingFactor;
  @override
  double get soundFrequencyLevel;

  /// Create a copy of NoiseGeneratorParameters
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NoiseGeneratorParametersImplCopyWith<_$NoiseGeneratorParametersImpl>
      get copyWith => throw _privateConstructorUsedError;
}
