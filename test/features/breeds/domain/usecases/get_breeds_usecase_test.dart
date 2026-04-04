import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/breeds/domain/entities/entities.dart';
import 'package:cat_breeds/features/breeds/domain/usecases/get_breeds_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mock_data.dart';
import '../../../../helpers/test_helpers.dart';

void main() {
  late GetBreedsUseCase useCase;
  late MockBreedRepository mockRepository;

  setUp(() {
    mockRepository = MockBreedRepository();
    useCase = GetBreedsUseCase(repository: mockRepository);
  });

  group('GetBreedsUseCase', () {
    const page = 0;

    test('should return breeds page when repository call succeeds', () async {
      // Arrange
      when(() => mockRepository.getBreeds(page)).thenAnswer((_) async => Success(mockBreedsPageEntity));

      // Act
      final result = await useCase(page);

      // Assert
      expect(result, isA<Success<BreedsPageEntity>>());
      result.when(
        success: (data) {
          expect(data.breeds.length, 2);
          expect(data.currentPage, 0);
          expect(data.totalCount, 2);
        },
        error: (_) => fail('Should not return error'),
      );
      verify(() => mockRepository.getBreeds(page)).called(1);
    });

    test('should return failure when repository call fails', () async {
      // Arrange
      const failure = ServerFailure(message: 'Server error');
      when(() => mockRepository.getBreeds(page)).thenAnswer((_) async => const Error(failure));

      // Act
      final result = await useCase(page);

      // Assert
      expect(result, isA<Error<BreedsPageEntity>>());
      result.when(
        success: (_) => fail('Should not return success'),
        error: (error) => expect(error.message, 'Server error'),
      );
    });
  });
}
