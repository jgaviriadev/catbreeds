import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/favorites/domain/usecases/delete_favorite_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/helpers.dart';

void main() {
  late DeleteFavoriteUseCase useCase;
  late MockFavoriteRepository mockRepository;

  setUp(() {
    mockRepository = MockFavoriteRepository();
    useCase = DeleteFavoriteUseCase(repository: mockRepository);
  });

  group('DeleteFavoriteUseCase', () {
    const favoriteId = 123;

    test('should return true when favorite is deleted successfully', () async {
      // Arrange
      when(() => mockRepository.deleteFavorite(favoriteId)).thenAnswer((_) async => const Success(true));

      // Act
      final result = await useCase(favoriteId);

      // Assert
      expect(result, isA<Success<bool>>());
      result.when(
        success: (deleted) => expect(deleted, true),
        error: (_) => fail('Should not return error'),
      );
      verify(() => mockRepository.deleteFavorite(favoriteId)).called(1);
    });

    test('should return failure when deletion fails', () async {
      // Arrange
      const failure = ServerFailure(message: 'Failed to delete');
      when(() => mockRepository.deleteFavorite(favoriteId)).thenAnswer((_) async => const Error(failure));

      // Act
      final result = await useCase(favoriteId);

      // Assert
      expect(result, isA<Error<bool>>());
      result.when(
        success: (_) => fail('Should not return success'),
        error: (error) => expect(error.message, 'Failed to delete'),
      );
    });
  });
}
