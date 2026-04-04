import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/breeds/domain/entities/entities.dart';
import 'package:cat_breeds/features/breeds/domain/usecases/get_breed_images_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/helpers.dart';

void main() {
  late GetBreedImagesUseCase useCase;
  late MockBreedRepository mockRepository;

  setUp(() {
    mockRepository = MockBreedRepository();
    useCase = GetBreedImagesUseCase(repository: mockRepository);
  });

  group('GetBreedImagesUseCase', () {
    final params = GetBreedImagesParams(breedIds: 'beng', limit: 10);

    test('should return breed images when repository call succeeds', () async {
      // Arrange
      when(
        () => mockRepository.getBreedImages(
          breedIds: params.breedIds,
          limit: params.limit,
        ),
      ).thenAnswer((_) async => Success(mockBreedImagesList));

      // Act
      final result = await useCase(params);

      // Assert
      expect(result, isA<Success<List<BreedImageEntity>>>());
      result.when(
        success: (images) {
          expect(images.length, 2);
          expect(images.first.id, 'img-1');
        },
        error: (_) => fail('Should not return error'),
      );
      verify(
        () => mockRepository.getBreedImages(
          breedIds: params.breedIds,
          limit: params.limit,
        ),
      ).called(1);
    });

    test('should return failure when repository call fails', () async {
      // Arrange
      const failure = ServerFailure(message: 'Server error');
      when(
        () => mockRepository.getBreedImages(
          breedIds: params.breedIds,
          limit: params.limit,
        ),
      ).thenAnswer((_) async => const Error(failure));

      // Act
      final result = await useCase(params);

      // Assert
      expect(result, isA<Error<List<BreedImageEntity>>>());
      result.when(
        success: (_) => fail('Should not return success'),
        error: (error) => expect(error.message, 'Server error'),
      );
      verify(
        () => mockRepository.getBreedImages(
          breedIds: params.breedIds,
          limit: params.limit,
        ),
      ).called(1);
    });
  });
}
