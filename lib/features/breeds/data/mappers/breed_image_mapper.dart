import 'package:cat_breeds/features/breeds/data/mappers/mappers.dart';
import 'package:cat_breeds/features/breeds/data/models/models.dart';
import 'package:cat_breeds/features/breeds/domain/entities/entities.dart';

extension BreedImageMapper on BreedImageModel {
  BreedImageEntity toEntity() {
    return BreedImageEntity(
      id: id ?? '',
      url: url ?? '',
      width: width ?? 0,
      height: height ?? 0,
      breeds: breeds?.map((b) => b.toEntity()).toList(),
    );
  }
}

extension BreedImageEntityMapper on BreedImageEntity {
  BreedImageModel toModel() {
    return BreedImageModel(
      id: id,
      url: url,
      width: width,
      height: height,
      breeds: breeds?.map((b) => b.toModel()).toList(),
    );
  }
}
