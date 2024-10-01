import 'dart:typed_data';

import 'package:mesmerizr/core/noise_generators/mixed_noise/mixed_noise_generator.dart';
import 'package:mesmerizr/core/noise_generators/brown_noise/brown_noise_generator.dart';
import 'package:mesmerizr/core/noise_generators/white_noise/white_noise_generator.dart';
import 'package:mesmerizr/core/noise_generators/pink_noise/pink_noise_generator.dart';
import 'package:riverpod/riverpod.dart';

class NoiseGenerationParameters {
  final double whiteNoiseLevel;
  final double pinkNoiseLevel;
  final double brownNoiseLevel;
  final double lowBassLevel;
  final double midBassLevel;
  final double highBassLevel;
  final double midLevel;
  final double highLevel;
  final double amplitude;

  const NoiseGenerationParameters({
    this.whiteNoiseLevel = 0.15,
    this.pinkNoiseLevel = 0.5,
    this.brownNoiseLevel = 0.7,
    this.lowBassLevel = 0.7,
    this.midBassLevel = 0.5,
    this.highBassLevel = 0.3,
    this.midLevel = 0.2,
    this.highLevel = 0.1,
    this.amplitude = 1.0,
  });

  NoiseGenerationParameters copyWith({
    double? whiteNoiseLevel,
    double? pinkNoiseLevel,
    double? brownNoiseLevel,
    double? lowBassLevel,
    double? midBassLevel,
    double? highBassLevel,
    double? midLevel,
    double? highLevel,
    double? amplitude,
  }) {
    return NoiseGenerationParameters(
      whiteNoiseLevel: whiteNoiseLevel ?? this.whiteNoiseLevel,
      pinkNoiseLevel: pinkNoiseLevel ?? this.pinkNoiseLevel,
      brownNoiseLevel: brownNoiseLevel ?? this.brownNoiseLevel,
      lowBassLevel: lowBassLevel ?? this.lowBassLevel,
      midBassLevel: midBassLevel ?? this.midBassLevel,
      highBassLevel: highBassLevel ?? this.highBassLevel,
      midLevel: midLevel ?? this.midLevel,
      highLevel: highLevel ?? this.highLevel,
      amplitude: amplitude ?? this.amplitude,
    );
  }
}

final generateNoiseProvider = Provider((ref) => GenerateNoise(
      mixedNoiseGenerator: MixedNoiseGenerator(),
      brownNoiseGenerator: BrownNoiseGenerator(),
      whiteNoiseGenerator: WhiteNoiseGenerator(),
      pinkNoiseGenerator: PinkNoiseGenerator(),
    ));

class GenerateNoise {
  final MixedNoiseGenerator _mixedNoiseGenerator;
  final BrownNoiseGenerator _brownNoiseGenerator;
  final WhiteNoiseGenerator _whiteNoiseGenerator;
  final PinkNoiseGenerator _pinkNoiseGenerator;

  GenerateNoise({
    required MixedNoiseGenerator mixedNoiseGenerator,
    required BrownNoiseGenerator brownNoiseGenerator,
    required WhiteNoiseGenerator whiteNoiseGenerator,
    required PinkNoiseGenerator pinkNoiseGenerator,
  })  : _mixedNoiseGenerator = mixedNoiseGenerator,
        _brownNoiseGenerator = brownNoiseGenerator,
        _whiteNoiseGenerator = whiteNoiseGenerator,
        _pinkNoiseGenerator = pinkNoiseGenerator;

  Uint8List call({
    required NoiseType type,
    required int sampleRate,
    required int numSamples,
    required NoiseGenerationParameters parameters,
  }) {
    switch (type) {
      case NoiseType.mixed:
        return _mixedNoiseGenerator.generateNoise(
          sampleRate,
          numSamples,
          parameters.amplitude,
        );
      case NoiseType.brown:
        return _brownNoiseGenerator.generateNoise(
          sampleRate,
          numSamples,
          parameters.brownNoiseLevel * parameters.amplitude,
        );
      case NoiseType.white:
        return _whiteNoiseGenerator.generateNoise(
          sampleRate,
          numSamples,
          parameters.whiteNoiseLevel * parameters.amplitude,
        );
      case NoiseType.pink:
        return _pinkNoiseGenerator.generateNoise(
          sampleRate,
          numSamples,
          parameters.pinkNoiseLevel * parameters.amplitude,
        );
      default:
        throw UnimplementedError('Noise type $type not implemented');
    }
  }
}

enum NoiseType { mixed, brown, white, pink }
