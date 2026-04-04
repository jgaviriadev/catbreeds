import 'package:cat_breeds/features/breeds/domain/entities/entities.dart';
import 'package:cat_breeds/features/favorites/domain/entities/entities.dart';

/// Mock data fixtures for tests

// Breeds
final mockBreedEntity = BreedEntity(
  id: '1',
  name: 'Abyssinian',
  origin: 'Egypt',
  description: 'Active and playful cat',
  temperament: 'Active, Energetic, Independent',
  lifeSpan: '14 - 15',
  adaptability: 5,
  affectionLevel: 5,
  childFriendly: 3,
  dogFriendly: 4,
  energyLevel: 5,
  intelligence: 5,
);

final List<BreedEntity> mockBreedsList = [
  mockBreedEntity,
  BreedEntity(
    id: '2',
    name: 'Bengal',
    origin: 'United States',
    description: 'Confident and curious',
    temperament: 'Alert, Agile, Energetic',
    lifeSpan: '12 - 15',
  ),
];

final mockBreedsPageEntity = BreedsPageEntity(
  breeds: mockBreedsList,
  currentPage: 0,
  totalCount: 2,
);

// Breed Images
final mockBreedImageEntity = BreedImageEntity(
  id: 'img-1',
  url: 'https://example.com/cat.jpg',
  width: 500,
  height: 400,
);

final List<BreedImageEntity> mockBreedImagesList = [
  mockBreedImageEntity,
  BreedImageEntity(
    id: 'img-2',
    url: 'https://example.com/cat2.jpg',
    width: 600,
    height: 450,
  ),
];

// Favorites
final mockFavoriteEntity = FavoriteEntity(
  id: 1,
  imageId: 'img-1',
  subId: 'user-123',
  image: BreedImageEntity(
    id: 'img-1',
    url: 'https://example.com/cat.jpg',
    width: 500,
    height: 400,
  ),
);

final List<FavoriteEntity> mockFavoritesList = [
  mockFavoriteEntity,
  FavoriteEntity(
    id: 2,
    imageId: 'img-2',
    subId: 'user-123',
  ),
];
