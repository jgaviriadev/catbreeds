import 'package:cat_breeds/features/breeds/domain/entities/entities.dart';

/// Entity representing a paginated response of breeds with metadata
class BreedsPageEntity {
  final List<BreedEntity> breeds;
  final int totalCount;
  final int currentPage;

  BreedsPageEntity({
    required this.breeds,
    required this.totalCount,
    required this.currentPage,
  });

  BreedsPageEntity copyWith({
    List<BreedEntity>? breeds,
    int? totalCount,
    int? currentPage,
  }) => BreedsPageEntity(
    breeds: breeds ?? this.breeds,
    totalCount: totalCount ?? this.totalCount,
    currentPage: currentPage ?? this.currentPage,
  );
}
