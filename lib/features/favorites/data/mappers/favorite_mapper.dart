import 'package:cat_breeds/features/breeds/data/mappers/mappers.dart';
import 'package:cat_breeds/features/favorites/data/models/models.dart';
import 'package:cat_breeds/features/favorites/domain/entities/entities.dart';

extension FavoriteMapper on FavoriteModel {
  FavoriteEntity toEntity() => FavoriteEntity(
    id: id,
    userId: userId,
    imageId: imageId,
    subId: subId,
    createdAt: createdAt,
    image: image?.toEntity(),
  );
}
