import 'package:flutter/material.dart';
import 'package:mesmerizr/domain/usecases/generate_noise.dart';

class NoiseControls extends StatelessWidget {
  final Function(NoiseGenerationParameters) onParametersChanged;
  final NoiseGenerationParameters parameters;

  const NoiseControls({
    Key? key,
    required this.onParametersChanged,
    required this.parameters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text('Noise Types',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          _buildSlider('White Noise', parameters.whiteNoiseLevel, (value) {
            onParametersChanged(parameters.copyWith(whiteNoiseLevel: value));
          }),
          _buildSlider('Pink Noise', parameters.pinkNoiseLevel, (value) {
            onParametersChanged(parameters.copyWith(pinkNoiseLevel: value));
          }),
          _buildSlider('Brown Noise', parameters.brownNoiseLevel, (value) {
            onParametersChanged(parameters.copyWith(brownNoiseLevel: value));
          }),
          SizedBox(height: 20),
          Text('Frequency Bands',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          _buildSlider('Low Bass', parameters.lowBassLevel, (value) {
            onParametersChanged(parameters.copyWith(lowBassLevel: value));
          }),
          _buildSlider('Mid Bass', parameters.midBassLevel, (value) {
            onParametersChanged(parameters.copyWith(midBassLevel: value));
          }),
          _buildSlider('High Bass', parameters.highBassLevel, (value) {
            onParametersChanged(parameters.copyWith(highBassLevel: value));
          }),
          _buildSlider('Mid', parameters.midLevel, (value) {
            onParametersChanged(parameters.copyWith(midLevel: value));
          }),
          _buildSlider('High', parameters.highLevel, (value) {
            onParametersChanged(parameters.copyWith(highLevel: value));
          }),
          _buildSlider('Amplitude', parameters.amplitude, (value) {
            onParametersChanged(parameters.copyWith(amplitude: value));
          }),
        ],
      ),
    );
  }

  Widget _buildSlider(
      String label, double value, ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Slider(
          value: value,
          min: 0.0,
          max: 1.0,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
