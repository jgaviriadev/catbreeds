import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/breeds/domain/entities/entities.dart';
import 'package:cat_breeds/features/breeds/domain/usecases/get_breed_image_by_id_usecase.dart';
import 'package:cat_breeds/features/breeds/domain/usecases/get_breeds_usecase.dart';
import 'package:cat_breeds/features/breeds/domain/usecases/get_initial_breeds_data_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/helpers.dart';

class MockGetBreedsUseCase extends Mock implements GetBreedsUseCase {}

class MockGetBreedImageByIdUseCase extends Mock implements GetBreedImageByIdUseCase {}

void main() {
  late GetBreedsWithImagesUseCase useCase;
  late MockGetBreedsUseCase mockGetBreedsUseCase;
  late MockGetBreedImageByIdUseCase mockGetBreedImageByIdUseCase;

  setUp(() {
    mockGetBreedsUseCase = MockGetBreedsUseCase();
    mockGetBreedImageByIdUseCase = MockGetBreedImageByIdUseCase();
    useCase = GetBreedsWithImagesUseCase(
      getBreedsUseCase: mockGetBreedsUseCase,
      getBreedImageByIdUseCase: mockGetBreedImageByIdUseCase,
    );
  });

  group('GetBreedsWithImagesUseCase', () {
    const page = 0;

    final breedWithImageRef = BreedEntity(
      id: '1',
      name: 'Abyssinian',
      referenceImageId: 'img-1',
    );

    final breedsPage = BreedsPageEntity(
      breeds: [breedWithImageRef],
      currentPage: 0,
      totalCount: 1,
    );

    test('should return breeds with images populated when all calls succeed', () async {
      // Arrange
      when(() => mockGetBreedsUseCase(page)).thenAnswer((_) async => Success(breedsPage));
      when(() => mockGetBreedImageByIdUseCase('img-1')).thenAnswer((_) async => Success(mockBreedImageEntity));

      // Act
      final result = await useCase(page);

      // Assert
      expect(result, isA<Success<BreedsPageEntity>>());
      result.when(
        success: (data) {
          expect(data.breeds.length, 1);
          expect(data.breeds.first.image, isNotNull);
          expect(data.breeds.first.image?.id, 'img-1');
        },
        error: (_) => fail('Should not return error'),
      );
      verify(() => mockGetBreedsUseCase(page)).called(1);
      verify(() => mockGetBreedImageByIdUseCase('img-1')).called(1);
    });

    test('should continue without image when image fetch fails', () async {
      // Arrange
      when(() => mockGetBreedsUseCase(page)).thenAnswer((_) async => Success(breedsPage));
      when(
        () => mockGetBreedImageByIdUseCase('img-1'),
      ).thenAnswer((_) async => const Error(ServerFailure(message: 'Image not found')));

      // Act
      final result = await useCase(page);

      // Assert
      expect(result, isA<Success<BreedsPageEntity>>());
      result.when(
        success: (data) {
          expect(data.breeds.length, 1);
          expect(data.breeds.first.image, isNull);
        },
        error: (_) => fail('Should not return error'),
      );
    });

    test('should return failure when breeds fetch fails', () async {
      // Arrange
      const failure = ServerFailure(message: 'Server error');
      when(() => mockGetBreedsUseCase(page)).thenAnswer((_) async => const Error(failure));

      // Act
      final result = await useCase(page);

      // Assert
      expect(result, isA<Error<BreedsPageEntity>>());
      result.when(
        success: (_) => fail('Should not return success'),
        error: (error) => expect(error.message, 'Server error'),
      );
      verify(() => mockGetBreedsUseCase(page)).called(1);
      verifyNever(() => mockGetBreedImageByIdUseCase(any()));
    });
  });
}
