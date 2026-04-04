import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/favorites/domain/usecases/add_favorite_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/test_helpers.dart';

void main() {
  late AddFavoriteUseCase useCase;
  late MockFavoriteRepository mockRepository;

  setUp(() {
    mockRepository = MockFavoriteRepository();
    useCase = AddFavoriteUseCase(repository: mockRepository);
  });

  group('AddFavoriteUseCase', () {
    final params = AddFavoriteParams(
      imageId: 'img-123',
      subId: 'user-456',
    );

    test('should return true when favorite is added successfully', () async {
      // Arrange
      when(
        () => mockRepository.addFavorite(
          imageId: params.imageId,
          subId: params.subId,
        ),
      ).thenAnswer((_) async => const Success(true));

      // Act
      final result = await useCase(params);

      // Assert
      expect(result, isA<Success<bool>>());
      result.when(
        success: (success) => expect(success, true),
        error: (_) => fail('Should not return error'),
      );
      verify(
        () => mockRepository.addFavorite(
          imageId: params.imageId,
          subId: params.subId,
        ),
      ).called(1);
    });

    test('should return failure when repository call fails', () async {
      // Arrange
      const failure = ServerFailure(message: 'Failed to add favorite');
      when(
        () => mockRepository.addFavorite(
          imageId: params.imageId,
          subId: params.subId,
        ),
      ).thenAnswer((_) async => const Error(failure));

      // Act
      final result = await useCase(params);

      // Assert
      expect(result, isA<Error<bool>>());
      result.when(
        success: (_) => fail('Should not return success'),
        error: (error) => expect(error.message, 'Failed to add favorite'),
      );
    });
  });
}
