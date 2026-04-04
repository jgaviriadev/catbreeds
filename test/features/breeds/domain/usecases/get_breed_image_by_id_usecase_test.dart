import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/breeds/domain/entities/entities.dart';
import 'package:cat_breeds/features/breeds/domain/usecases/get_breed_image_by_id_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/helpers.dart';

void main() {
  late GetBreedImageByIdUseCase useCase;
  late MockBreedRepository mockRepository;

  setUp(() {
    mockRepository = MockBreedRepository();
    useCase = GetBreedImageByIdUseCase(repository: mockRepository);
  });

  group('GetBreedImageByIdUseCase', () {
    const imageId = 'img-1';

    test('should return breed image when repository call succeeds', () async {
      // Arrange
      when(() => mockRepository.getBreedImageById(imageId)).thenAnswer((_) async => Success(mockBreedImageEntity));

      // Act
      final result = await useCase(imageId);

      // Assert
      expect(result, isA<Success<BreedImageEntity>>());
      result.when(
        success: (image) {
          expect(image.id, 'img-1');
          expect(image.url, 'https://example.com/cat.jpg');
        },
        error: (_) => fail('Should not return error'),
      );
      verify(() => mockRepository.getBreedImageById(imageId)).called(1);
    });

    test('should return failure when repository call fails', () async {
      // Arrange
      const failure = ServerFailure(message: 'Image not found');
      when(() => mockRepository.getBreedImageById(imageId)).thenAnswer((_) async => const Error(failure));

      // Act
      final result = await useCase(imageId);

      // Assert
      expect(result, isA<Error<BreedImageEntity>>());
      result.when(
        success: (_) => fail('Should not return success'),
        error: (error) => expect(error.message, 'Image not found'),
      );
      verify(() => mockRepository.getBreedImageById(imageId)).called(1);
    });
  });
}
