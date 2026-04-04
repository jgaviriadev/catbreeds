import 'package:cat_breeds/features/breeds/data/mappers/breed_mapper.dart';
import 'package:cat_breeds/features/breeds/data/models/breeds_page_model.dart';
import 'package:cat_breeds/features/breeds/domain/entities/breeds_page_entity.dart';

extension BreedsPageModelMapper on BreedsPageModel {
  BreedsPageEntity toEntity(int currentPage) {
    return BreedsPageEntity(
      breeds: breeds.map((breed) => breed.toEntity()).toList(),
      totalCount: totalCount,
      currentPage: currentPage,
    );
  }
}
