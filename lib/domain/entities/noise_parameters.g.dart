// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'noise_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NoiseParametersImpl _$$NoiseParametersImplFromJson(
        Map<String, dynamic> json) =>
    _$NoiseParametersImpl(
      frequency: (json['frequency'] as num).toDouble(),
      amplitude: (json['amplitude'] as num).toDouble(),
      colorType: json['colorType'] as String,
    );

Map<String, dynamic> _$$NoiseParametersImplToJson(
        _$NoiseParametersImpl instance) =>
    <String, dynamic>{
      'frequency': instance.frequency,
      'amplitude': instance.amplitude,
      'colorType': instance.colorType,
    };
