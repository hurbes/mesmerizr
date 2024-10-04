import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/noise_provider.dart';

class NoiseGeneratorScreen extends ConsumerWidget {
  const NoiseGeneratorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noiseState = ref.watch(noiseProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Noise Generator')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: noiseState.isLoading
                  ? null
                  : () => ref.read(noiseProvider.notifier).toggleNoise(),
              child: Text(noiseState.isLoading ? 'Loading...' : 'Toggle Noise'),
            ),
            if (noiseState.hasError)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error: ${noiseState.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
