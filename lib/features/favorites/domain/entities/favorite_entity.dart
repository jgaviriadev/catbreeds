import 'package:cat_breeds/features/breeds/domain/entities/entities.dart';

class FavoriteEntity {
  final int? id;
  final String? userId;
  final String? imageId;
  final String? subId;
  final DateTime? createdAt;
  final BreedImageEntity? image;

  FavoriteEntity({
    this.id,
    this.userId,
    this.imageId,
    this.subId,
    this.createdAt,
    this.image,
  });

  FavoriteEntity copyWith({
    int? id,
    String? userId,
    String? imageId,
    String? subId,
    DateTime? createdAt,
    BreedImageEntity? image,
  }) => FavoriteEntity(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    imageId: imageId ?? this.imageId,
    subId: subId ?? this.subId,
    createdAt: createdAt ?? this.createdAt,
    image: image ?? this.image,
  );
}
