import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/favorites/domain/entities/entities.dart';
import 'package:cat_breeds/features/favorites/domain/usecases/get_favorites_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/helpers.dart';

void main() {
  late GetFavoritesUseCase useCase;
  late MockFavoriteRepository mockRepository;

  setUp(() {
    mockRepository = MockFavoriteRepository();
    useCase = GetFavoritesUseCase(repository: mockRepository);
  });

  group('GetFavoritesUseCase', () {
    test('should return list of favorites when repository call succeeds', () async {
      // Arrange
      when(() => mockRepository.getFavorites()).thenAnswer((_) async => Success(mockFavoritesList));

      // Act
      final result = await useCase(const NoParams());

      // Assert
      expect(result, isA<Success<List<FavoriteEntity>>>());
      result.when(
        success: (favorites) => expect(favorites.length, 2),
        error: (_) => fail('Should not return error'),
      );
      verify(() => mockRepository.getFavorites()).called(1);
    });

    test('should return failure when repository call fails', () async {
      // Arrange
      const failure = ServerFailure(message: 'Failed to fetch favorites');
      when(() => mockRepository.getFavorites()).thenAnswer((_) async => const Error(failure));

      // Act
      final result = await useCase(const NoParams());

      // Assert
      expect(result, isA<Error<List<FavoriteEntity>>>());
      result.when(
        success: (_) => fail('Should not return success'),
        error: (error) => expect(error.message, 'Failed to fetch favorites'),
      );
    });
  });
}
