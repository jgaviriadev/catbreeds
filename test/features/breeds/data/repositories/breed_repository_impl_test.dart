import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/breeds/data/datasources/breed_datasource.dart';
import 'package:cat_breeds/features/breeds/data/models/models.dart';
import 'package:cat_breeds/features/breeds/data/repositories/breed_repository_impl.dart';
import 'package:cat_breeds/features/breeds/domain/entities/entities.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBreedDatasource extends Mock implements BreedDatasource {}

void main() {
  late BreedRepositoryImpl repository;
  late MockBreedDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockBreedDatasource();
    repository = BreedRepositoryImpl(dataSource: mockDatasource);
  });

  group('BreedRepositoryImpl', () {
    group('searchBreeds', () {
      const query = 'Bengal';
      
      final mockBreedModels = [
        BreedModel(id: '1', name: 'Bengal', origin: 'United States'),
        BreedModel(id: '2', name: 'Bengal Tiger', origin: 'Asia'),
      ];

      test('should return breeds list when datasource call succeeds',
          () async {
        // Arrange
        when(() => mockDatasource.searchBreeds(query))
            .thenAnswer((_) async => mockBreedModels);

        // Act
        final result = await repository.searchBreeds(query);

        // Assert
        expect(result, isA<Success<List<BreedEntity>>>());
        result.when(
          success: (breeds) => expect(breeds.length, 2),
          error: (_) => fail('Should not return error'),
        );
        verify(() => mockDatasource.searchBreeds(query)).called(1);
      });

      test('should return ServerFailure when datasource throws exception',
          () async {
        // Arrange
        when(() => mockDatasource.searchBreeds(query))
            .thenThrow(ServerException(message: 'API error'));

        // Act
        final result = await repository.searchBreeds(query);

        // Assert
        expect(result, isA<Error<List<BreedEntity>>>());
        result.when(
          success: (_) => fail('Should not return success'),
          error: (failure) => expect(failure, isA<ServerFailure>()),
        );
      });
    });
  });
}
