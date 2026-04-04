import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/breeds/domain/entities/entities.dart';
import 'package:cat_breeds/features/breeds/domain/usecases/search_breeds_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/helpers.dart';

void main() {
  late SearchBreedsUseCase useCase;
  late MockBreedRepository mockRepository;

  setUp(() {
    mockRepository = MockBreedRepository();
    useCase = SearchBreedsUseCase(repository: mockRepository);
  });

  group('SearchBreedsUseCase', () {
    const query = 'Bengal';

    test('should return breeds list when search succeeds', () async {
      // Arrange
      when(() => mockRepository.searchBreeds(query)).thenAnswer((_) async => Success(mockBreedsList));

      // Act
      final result = await useCase(query);

      // Assert
      expect(result, isA<Success<List<BreedEntity>>>());
      result.when(
        success: (breeds) {
          expect(breeds.length, 2);
          expect(breeds, mockBreedsList);
        },
        error: (_) => fail('Should not return error'),
      );
      verify(() => mockRepository.searchBreeds(query)).called(1);
    });

    test('should return empty list when no breeds match', () async {
      // Arrange
      when(() => mockRepository.searchBreeds(query)).thenAnswer((_) async => const Success([]));

      // Act
      final result = await useCase(query);

      // Assert
      result.when(
        success: (breeds) => expect(breeds, isEmpty),
        error: (_) => fail('Should not return error'),
      );
    });

    test('should return failure when search fails', () async {
      // Arrange
      const failure = ServerFailure(message: 'Search failed');
      when(() => mockRepository.searchBreeds(query)).thenAnswer((_) async => const Error(failure));

      // Act
      final result = await useCase(query);

      // Assert
      expect(result, isA<Error<List<BreedEntity>>>());
      result.when(
        success: (_) => fail('Should not return success'),
        error: (error) => expect(error.message, 'Search failed'),
      );
    });
  });
}
