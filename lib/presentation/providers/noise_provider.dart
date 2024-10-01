import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mesmerizr/domain/usecases/generate_noise.dart';
import 'dart:typed_data';

class NoiseNotifier extends AsyncNotifier<Uint8List> {
  @override
  Future<Uint8List> build() async {
    return Uint8List(0);
  }

  Future<void> generateNoise(
    NoiseType type,
    int sampleRate,
    int numSamples,
    NoiseGenerationParameters parameters,
  ) async {
    state = const AsyncValue.loading();
    try {
      final GenerateNoise generateNoise = ref.read(generateNoiseProvider);
      final result = await compute(
        (Map<String, dynamic> args) => generateNoise(
          type: args['type'],
          sampleRate: args['sampleRate'],
          numSamples: args['numSamples'],
          parameters: args['parameters'],
        ),
        {
          'type': type,
          'sampleRate': sampleRate,
          'numSamples': sampleRate * 5,
          'parameters': parameters,
        },
      );
      debugPrint('Generated noise length: ${result.length}');
      debugPrint('First few samples: ${result.take(10).toList()}');
      if (result.isEmpty) {
        throw Exception('Generated noise is empty');
      }
      state = AsyncValue.data(result);
    } catch (e, stackTrace) {
      debugPrint('Error generating noise: $e');
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

final noiseProvider = AsyncNotifierProvider<NoiseNotifier, Uint8List>(() {
  return NoiseNotifier();
});
