import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mesmerizr/domain/entities/noise_parameters.dart';
import 'package:mesmerizr/domain/usecases/generate_noise.dart';
import 'package:mesmerizr/data/datasources/noise_generator_datasource.dart';
import 'package:riverpod/riverpod.dart';

class MockNoiseGeneratorDataSource extends Mock
    implements NoiseGeneratorDataSource {}

void main() {
  late GenerateNoise generateNoise;
  late MockNoiseGeneratorDataSource mockDataSource;
  late ProviderContainer container;

  setUp(() {
    mockDataSource = MockNoiseGeneratorDataSource();
    container = ProviderContainer();
    generateNoise = GenerateNoise(container);
    (generateNoise as dynamic)._dataSource = mockDataSource;
  });

  final tNoiseParameters = NoiseParameters(
    frequency: 440,
    amplitude: 0.5,
    colorType: 'white',
  );

  final tNoiseData = List.generate(44100, (index) => 0.0);

  test(
    'should get noise data from the data source',
    () async {
      // arrange
      when(() => mockDataSource.generateNoise(any()))
          .thenAnswer((_) async => tNoiseData);

      // act
      final result = await generateNoise.build(tNoiseParameters);

      // assert
      expect(result, equals(tNoiseData));
      verify(() => mockDataSource.generateNoise(tNoiseParameters)).called(1);
      verifyNoMoreInteractions(mockDataSource);
    },
  );
}
