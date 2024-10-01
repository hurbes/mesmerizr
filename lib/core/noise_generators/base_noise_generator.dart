import 'dart:typed_data';
import '../parameters/noise_generator_parameters.dart';

abstract class BaseNoiseGenerator {
  /// The name of the noise generator
  String get name;

  /// The current parameters of the noise generator
  NoiseGeneratorParameters get parameters;

  /// Generates noise samples
  ///
  /// [sampleRate]: The number of samples per second
  /// [bufferSize]: The number of samples to generate
  /// Returns a Float64List of generated noise samples
  Float64List generateNoise(int sampleRate, int bufferSize);

  /// Updates the parameters of the noise generator
  ///
  /// This method should be implemented by subclasses to update their specific parameters
  void updateParameters(NoiseGeneratorParameters newParameters);

  /// Applies filters to the generated noise
  ///
  /// [buffer]: The input buffer of noise samples
  /// [sampleRate]: The number of samples per second
  /// Returns the filtered buffer
  Float64List applyFilters(Float64List buffer, int sampleRate);

  /// Converts a Float64List to a Uint8List for audio output
  ///
  /// [buffer]: The input buffer of float samples
  /// Returns the converted Uint8List
  Uint8List convertToUint8(Float64List buffer);

  /// Generates a complete noise sample with all processing steps
  ///
  /// [sampleRate]: The number of samples per second
  /// [bufferSize]: The number of samples to generate
  /// Returns a Uint8List of the final processed noise samples
  Uint8List generateCompleteSample(int sampleRate, int bufferSize) {
    Float64List rawNoise = generateNoise(sampleRate, bufferSize);
    Float64List filteredNoise = applyFilters(rawNoise, sampleRate);
    return convertToUint8(filteredNoise);
  }
}
