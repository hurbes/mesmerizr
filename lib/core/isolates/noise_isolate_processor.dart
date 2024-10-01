import 'dart:isolate';
import 'dart:typed_data';
import '../parameters/noise_generator_parameters.dart';
import 'isolate_processor.dart';

typedef NoiseGenerationFunction = Uint8List Function(
    NoiseGeneratorParameters, int, int);

class NoiseIsolateProcessor {
  final IsolateProcessor _processor = IsolateProcessor();

  Future<void> initialize(NoiseGenerationFunction generationFunction) async {
    await _processor.initialize<NoiseGenerationFunction>(
      _noiseGenerationEntry,
      generationFunction,
    );
  }

  Future<Uint8List> generateNoise(
    NoiseGeneratorParameters parameters,
    int sampleRate,
    int bufferSize,
  ) async {
    return await _processor.compute<Map<String, dynamic>, Uint8List>({
      'parameters': parameters,
      'sampleRate': sampleRate,
      'bufferSize': bufferSize,
    });
  }

  void dispose() {
    _processor.dispose();
  }

  static void _noiseGenerationEntry(
      NoiseGenerationFunction generationFunction, SendPort sendPort) {
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);

    receivePort.listen((message) {
      final params = message.$1 as Map<String, dynamic>;
      final replyTo = message.$2 as SendPort;

      try {
        final noise = generationFunction(
          params['parameters'] as NoiseGeneratorParameters,
          params['sampleRate'] as int,
          params['bufferSize'] as int,
        );
        replyTo.send(noise);
      } catch (e) {
        replyTo.send(Exception('Error generating noise: $e'));
      }
    });
  }
}
