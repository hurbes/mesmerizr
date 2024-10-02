import 'dart:async';
import 'dart:isolate';
import 'dart:typed_data';
import '../noise_generators/base_noise_generator.dart';
import '../isolate_processor/isolate_processor.dart';
import '../parameters/noise_generator_parameters.dart';
import 'package:logger/logger.dart';

class NoiseProcessor {
  final BaseNoiseGenerator _noiseGenerator;
  final IsolateProcessor _isolateProcessor;
  final Logger _logger = Logger();

  final StreamController<Uint8List> _noiseStreamController =
      StreamController<Uint8List>.broadcast();
  late Stream<Uint8List> _noiseStream;
  bool _isInitialized = false;
  bool _isGenerating = false;

  NoiseProcessor(this._noiseGenerator, this._isolateProcessor);

  Future<void> initialize() async {
    if (_isInitialized) {
      _logger.w('NoiseProcessor is already initialized');
      return;
    }

    _logger.d('Initializing NoiseProcessor');
    _noiseStream = _noiseStreamController.stream;
    await _isolateProcessor.initialize();
    _isInitialized = true;
    _logger.d('NoiseProcessor initialized successfully');
  }

  Stream<Uint8List> get noiseStream {
    if (!_isInitialized) {
      throw StateError('NoiseProcessor is not initialized');
    }
    return _noiseStream;
  }

  Future<void> startGeneratingNoise() async {
    if (!_isInitialized) {
      throw StateError('NoiseProcessor is not initialized');
    }

    if (_isGenerating) {
      _logger.w('Noise generation is already in progress');
      return;
    }

    _logger.d('Starting noise generation');
    _isGenerating = true;

    await _isolateProcessor.start((sendPort) {
      _generateNoise(sendPort, _noiseGenerator);
    });

    _isolateProcessor.listen((message) {
      if (message is Uint8List) {
        _noiseStreamController.add(message);
      }
    });
  }

  Future<void> stopGeneratingNoise() async {
    if (!_isGenerating) {
      _logger.w('Noise generation is not in progress');
      return;
    }

    _logger.d('Stopping noise generation');
    await _isolateProcessor.stop();
    _isGenerating = false;
  }

  static void _generateNoise(SendPort sendPort, BaseNoiseGenerator generator) {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      final noiseBuffer = generator.generateCompleteSample(
          44100, 4410); // 0.1 seconds of audio at 44.1kHz
      sendPort.send(noiseBuffer);
    });
  }

  Future<void> updateNoiseParameters(
      NoiseGeneratorParameters parameters) async {
    _noiseGenerator.updateParameters(parameters);
    if (_isGenerating) {
      await _isolateProcessor.send(_noiseGenerator);
    }
  }

  Future<void> dispose() async {
    _logger.d('Disposing NoiseProcessor');
    if (_isGenerating) {
      await stopGeneratingNoise();
    }
    await _noiseStreamController.close();
    await _isolateProcessor.dispose();
    _isInitialized = false;
  }

  bool get isInitialized => _isInitialized;
  bool get isGenerating => _isGenerating;
}
