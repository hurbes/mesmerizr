// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Failure {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() audioFailure,
    required TResult Function() shaderFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? audioFailure,
    TResult? Function()? shaderFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? audioFailure,
    TResult Function()? shaderFailure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AudioFailure value) audioFailure,
    required TResult Function(ShaderFailure value) shaderFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AudioFailure value)? audioFailure,
    TResult? Function(ShaderFailure value)? shaderFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AudioFailure value)? audioFailure,
    TResult Function(ShaderFailure value)? shaderFailure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) then) =
      _$FailureCopyWithImpl<$Res, Failure>;
}

/// @nodoc
class _$FailureCopyWithImpl<$Res, $Val extends Failure>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AudioFailureImplCopyWith<$Res> {
  factory _$$AudioFailureImplCopyWith(
          _$AudioFailureImpl value, $Res Function(_$AudioFailureImpl) then) =
      __$$AudioFailureImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AudioFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$AudioFailureImpl>
    implements _$$AudioFailureImplCopyWith<$Res> {
  __$$AudioFailureImplCopyWithImpl(
      _$AudioFailureImpl _value, $Res Function(_$AudioFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AudioFailureImpl implements AudioFailure {
  const _$AudioFailureImpl();

  @override
  String toString() {
    return 'Failure.audioFailure()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AudioFailureImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() audioFailure,
    required TResult Function() shaderFailure,
  }) {
    return audioFailure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? audioFailure,
    TResult? Function()? shaderFailure,
  }) {
    return audioFailure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? audioFailure,
    TResult Function()? shaderFailure,
    required TResult orElse(),
  }) {
    if (audioFailure != null) {
      return audioFailure();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AudioFailure value) audioFailure,
    required TResult Function(ShaderFailure value) shaderFailure,
  }) {
    return audioFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AudioFailure value)? audioFailure,
    TResult? Function(ShaderFailure value)? shaderFailure,
  }) {
    return audioFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AudioFailure value)? audioFailure,
    TResult Function(ShaderFailure value)? shaderFailure,
    required TResult orElse(),
  }) {
    if (audioFailure != null) {
      return audioFailure(this);
    }
    return orElse();
  }
}

abstract class AudioFailure implements Failure {
  const factory AudioFailure() = _$AudioFailureImpl;
}

/// @nodoc
abstract class _$$ShaderFailureImplCopyWith<$Res> {
  factory _$$ShaderFailureImplCopyWith(
          _$ShaderFailureImpl value, $Res Function(_$ShaderFailureImpl) then) =
      __$$ShaderFailureImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ShaderFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ShaderFailureImpl>
    implements _$$ShaderFailureImplCopyWith<$Res> {
  __$$ShaderFailureImplCopyWithImpl(
      _$ShaderFailureImpl _value, $Res Function(_$ShaderFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ShaderFailureImpl implements ShaderFailure {
  const _$ShaderFailureImpl();

  @override
  String toString() {
    return 'Failure.shaderFailure()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ShaderFailureImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() audioFailure,
    required TResult Function() shaderFailure,
  }) {
    return shaderFailure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? audioFailure,
    TResult? Function()? shaderFailure,
  }) {
    return shaderFailure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? audioFailure,
    TResult Function()? shaderFailure,
    required TResult orElse(),
  }) {
    if (shaderFailure != null) {
      return shaderFailure();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AudioFailure value) audioFailure,
    required TResult Function(ShaderFailure value) shaderFailure,
  }) {
    return shaderFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AudioFailure value)? audioFailure,
    TResult? Function(ShaderFailure value)? shaderFailure,
  }) {
    return shaderFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AudioFailure value)? audioFailure,
    TResult Function(ShaderFailure value)? shaderFailure,
    required TResult orElse(),
  }) {
    if (shaderFailure != null) {
      return shaderFailure(this);
    }
    return orElse();
  }
}

abstract class ShaderFailure implements Failure {
  const factory ShaderFailure() = _$ShaderFailureImpl;
}
