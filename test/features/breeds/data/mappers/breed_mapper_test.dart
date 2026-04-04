import 'package:cat_breeds/features/breeds/data/mappers/breed_mapper.dart';
import 'package:cat_breeds/features/breeds/data/models/models.dart';
import 'package:cat_breeds/features/breeds/domain/entities/entities.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BreedMapper', () {
    final breedModel = BreedModel(
      id: '1',
      name: 'Abyssinian',
      origin: 'Egypt',
      description: 'Active and playful cat',
      temperament: 'Active, Energetic',
      lifeSpan: '14 - 15',
      adaptability: 5,
      affectionLevel: 5,
      childFriendly: 3,
    );

    test('should convert BreedModel to BreedEntity', () {
      // Act
      final entity = breedModel.toEntity();

      // Assert
      expect(entity, isA<BreedEntity>());
      expect(entity.id, breedModel.id);
      expect(entity.name, breedModel.name);
      expect(entity.origin, breedModel.origin);
      expect(entity.description, breedModel.description);
      expect(entity.temperament, breedModel.temperament);
      expect(entity.lifeSpan, breedModel.lifeSpan);
      expect(entity.adaptability, breedModel.adaptability);
      expect(entity.affectionLevel, breedModel.affectionLevel);
      expect(entity.childFriendly, breedModel.childFriendly);
    });

    test('should convert BreedEntity to BreedModel', () {
      // Arrange
      final entity = BreedEntity(
        id: '2',
        name: 'Bengal',
        origin: 'United States',
        description: 'Confident and curious',
        temperament: 'Alert, Agile',
        lifeSpan: '12 - 15',
        energyLevel: 5,
        intelligence: 5,
      );

      // Act
      final model = entity.toModel();

      // Assert
      expect(model, isA<BreedModel>());
      expect(model.id, entity.id);
      expect(model.name, entity.name);
      expect(model.origin, entity.origin);
      expect(model.description, entity.description);
      expect(model.temperament, entity.temperament);
      expect(model.lifeSpan, entity.lifeSpan);
      expect(model.energyLevel, entity.energyLevel);
      expect(model.intelligence, entity.intelligence);
    });
  });
}
