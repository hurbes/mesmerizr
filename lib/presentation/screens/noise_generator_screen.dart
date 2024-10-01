import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mesmerizr/domain/usecases/generate_noise.dart';
import 'package:mesmerizr/presentation/providers/noise_provider.dart';
import 'package:mesmerizr/presentation/widgets/noise_visualizer.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:typed_data';
import 'package:mesmerizr/core/audio/uint8list_audio_source.dart';
import 'package:flutter/foundation.dart';
import 'package:mesmerizr/core/audio/wav_converter.dart';

class NoiseGeneratorScreen extends ConsumerStatefulWidget {
  const NoiseGeneratorScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<NoiseGeneratorScreen> createState() =>
      _NoiseGeneratorScreenState();
}

class _NoiseGeneratorScreenState extends ConsumerState<NoiseGeneratorScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  NoiseGenerationParameters _parameters = const NoiseGenerationParameters();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    // Generate initial noise when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _generateNoise(NoiseType.white);
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noiseState = ref.watch(noiseProvider);

    // Debug print to check the current state
    debugPrint('Current noiseState: $noiseState');

    return Scaffold(
      appBar: AppBar(title: const Text('Noise Generator')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 200, // Adjust this value as needed
                        child: NoiseVisualizer(
                          noiseData: noiseState.value
                                  ?.map((e) => e.toDouble())
                                  .toList() ??
                              [],
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildNoiseTypeButtons(),
                      const SizedBox(height: 16),
                      _buildSliders(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildPlayButton(noiseState),
              const SizedBox(height: 8),
              _buildNoiseInfo(noiseState),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoiseTypeButtons() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: NoiseType.values.map((type) {
        return ElevatedButton(
          onPressed: () => _generateNoise(type),
          child: Text(type.toString().split('.').last),
        );
      }).toList(),
    );
  }

  Widget _buildSliders() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSlider('White Noise', _parameters.whiteNoiseLevel, (value) {
          setState(() {
            _parameters = _parameters.copyWith(whiteNoiseLevel: value);
          });
          _updateNoise();
        }),
        _buildSlider('Pink Noise', _parameters.pinkNoiseLevel, (value) {
          setState(() {
            _parameters = _parameters.copyWith(pinkNoiseLevel: value);
          });
          _updateNoise();
        }),
        _buildSlider('Brown Noise', _parameters.brownNoiseLevel, (value) {
          setState(() {
            _parameters = _parameters.copyWith(brownNoiseLevel: value);
          });
          _updateNoise();
        }),
        _buildSlider('Low Bass', _parameters.lowBassLevel, (value) {
          setState(() {
            _parameters = _parameters.copyWith(lowBassLevel: value);
          });
          _updateNoise();
        }),
        _buildSlider('Mid Bass', _parameters.midBassLevel, (value) {
          setState(() {
            _parameters = _parameters.copyWith(midBassLevel: value);
          });
          _updateNoise();
        }),
        _buildSlider('High Bass', _parameters.highBassLevel, (value) {
          setState(() {
            _parameters = _parameters.copyWith(highBassLevel: value);
          });
          _updateNoise();
        }),
        _buildSlider('Mid', _parameters.midLevel, (value) {
          setState(() {
            _parameters = _parameters.copyWith(midLevel: value);
          });
          _updateNoise();
        }),
        _buildSlider('High', _parameters.highLevel, (value) {
          setState(() {
            _parameters = _parameters.copyWith(highLevel: value);
          });
          _updateNoise();
        }),
        _buildSlider('Amplitude', _parameters.amplitude, (value) {
          setState(() {
            _parameters = _parameters.copyWith(amplitude: value);
          });
          _updateNoise();
        }),
      ],
    );
  }

  Widget _buildSlider(
      String label, double value, ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        Slider(
          value: value,
          onChanged: onChanged,
          min: 0,
          max: 1,
        ),
      ],
    );
  }

  Widget _buildPlayButton(AsyncValue<Uint8List> noiseState) {
    return ElevatedButton(
      onPressed: noiseState.when(
        data: (_) => _togglePlayPause,
        loading: () => null,
        error: (_, __) => null,
      ),
      child: Text(_isPlaying ? 'Pause' : 'Play'),
    );
  }

  Widget _buildNoiseInfo(AsyncValue<Uint8List> noiseState) {
    return noiseState.when(
      data: (noise) => Text(
        'Noise generated: ${noise.length} samples',
        textAlign: TextAlign.center,
      ),
      loading: () => Column(
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 8),
          Text(
            'Generating noise...',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
      error: (error, stackTrace) => Text(
        'Error: $error\n${kDebugMode ? stackTrace.toString() : ''}',
        textAlign: TextAlign.center,
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
    );
  }

  void _generateNoise(NoiseType type) {
    debugPrint('Generating noise of type: $type');
    ref.read(noiseProvider.notifier).generateNoise(
          type,
          44100, // Sample rate
          44100, // 1 second of audio
          _parameters,
        );
  }

  void _updateNoise() {
    if (_isPlaying) {
      _generateNoise(
          NoiseType.mixed); // Assuming we want to update with mixed noise
    }
  }

  Future<void> _togglePlayPause() async {
    final noise = ref.read(noiseProvider).value;
    if (noise != null && noise.isNotEmpty) {
      setState(() {
        _isPlaying = !_isPlaying;
      });

      try {
        if (!_isPlaying) {
          await _audioPlayer.pause();
        } else {
          // Use compute to run WAV conversion in a separate isolate
          final wavData =
              await compute(WavConverter.convertToWav, [noise, 44100]);
          final audioSource = UInt8ListAudioSource(wavData);

          await _audioPlayer.setAudioSource(
            LoopingAudioSource(child: audioSource, count: 9999999),
            preload: false,
          );

          await _audioPlayer.play();
        }
      } catch (e) {
        debugPrint('Error playing audio: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error playing audio: $e'),
            backgroundColor: Colors.red,
          ),
        );
        // Revert the playing state if an error occurred
        setState(() {
          _isPlaying = !_isPlaying;
        });
      }
    } else {
      debugPrint('No noise data available or noise data is empty');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No noise data available. Generate noise first.'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }
}
