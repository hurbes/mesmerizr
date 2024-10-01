import 'dart:isolate';
import 'dart:math';
import 'package:mesmerizr/domain/entities/noise_parameters.dart';

class NoiseGeneratorDataSource {
  Future<List<double>> generateNoise(NoiseParameters parameters) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_generateNoiseIsolate, receivePort.sendPort);

    final sendPort = await receivePort.first as SendPort;
    final response = ReceivePort();

    sendPort.send([parameters, response.sendPort]);

    final result = await response.first as List<double>;
    return result;
  }

  static void _generateNoiseIsolate(SendPort sendPort) {
    final port = ReceivePort();
    sendPort.send(port.sendPort);

    port.listen((message) {
      final parameters = message[0] as NoiseParameters;
      final replyTo = message[1] as SendPort;

      final result = _generateNoise(parameters);
      replyTo.send(result);
    });
  }

  static List<double> _generateNoise(NoiseParameters parameters) {
    switch (parameters.colorType.toLowerCase()) {
      case 'white':
        return _generateWhiteNoise(parameters);
      case 'pink':
        return _generatePinkNoise(parameters);
      case 'brown':
        return _generateBrownNoise(parameters);
      default:
        throw ArgumentError(
            'Unsupported noise color type: ${parameters.colorType}');
    }
  }

  static List<double> _generateWhiteNoise(NoiseParameters parameters) {
    final random = Random();
    return List.generate(44100, (_) {
      return (random.nextDouble() * 2 - 1) * parameters.amplitude;
    });
  }

  static List<double> _generatePinkNoise(NoiseParameters parameters) {
    final random = Random();
    final b = List.filled(7, 0.0);
    return List.generate(44100, (_) {
      double white = random.nextDouble() * 2 - 1;
      b[0] = 0.99886 * b[0] + white * 0.0555179;
      b[1] = 0.99332 * b[1] + white * 0.0750759;
      b[2] = 0.96900 * b[2] + white * 0.1538520;
      b[3] = 0.86650 * b[3] + white * 0.3104856;
      b[4] = 0.55000 * b[4] + white * 0.5329522;
      b[5] = -0.7616 * b[5] - white * 0.0168980;
      double pink =
          b[0] + b[1] + b[2] + b[3] + b[4] + b[5] + b[6] + white * 0.5362;
      b[6] = white * 0.115926;
      return (pink / 5) * parameters.amplitude; // Normalize
    });
  }

  static List<double> _generateBrownNoise(NoiseParameters parameters) {
    final random = Random();
    double lastValue = 0;
    return List.generate(44100, (_) {
      double white = random.nextDouble() * 2 - 1;
      lastValue = (lastValue + (0.02 * white)) / 1.02;
      return lastValue * parameters.amplitude;
    });
  }
}
