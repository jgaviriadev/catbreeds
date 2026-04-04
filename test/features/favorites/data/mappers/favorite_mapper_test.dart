import 'package:cat_breeds/features/favorites/data/mappers/favorite_mapper.dart';
import 'package:cat_breeds/features/favorites/data/models/favorite_model.dart';
import 'package:cat_breeds/features/favorites/domain/entities/favorite_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FavoriteMapper', () {
    test('should convert FavoriteModel to FavoriteEntity', () {
      // Arrange
      final model = FavoriteModel(
        id: 1,
        userId: 'user-123',
        imageId: 'img-456',
        subId: 'sub-789',
        createdAt: DateTime(2024, 1, 1),
      );

      // Act
      final entity = model.toEntity();

      // Assert
      expect(entity, isA<FavoriteEntity>());
      expect(entity.id, model.id);
      expect(entity.userId, model.userId);
      expect(entity.imageId, model.imageId);
      expect(entity.subId, model.subId);
      expect(entity.createdAt, model.createdAt);
    });

    test('should handle null values correctly', () {
      // Arrange
      final model = FavoriteModel(
        id: 2,
        imageId: 'img-123',
      );

      // Act
      final entity = model.toEntity();

      // Assert
      expect(entity.id, 2);
      expect(entity.imageId, 'img-123');
      expect(entity.userId, isNull);
      expect(entity.subId, isNull);
      expect(entity.createdAt, isNull);
      expect(entity.image, isNull);
    });
  });
}
