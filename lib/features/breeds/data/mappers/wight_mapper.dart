import 'package:cat_breeds/features/breeds/data/models/models.dart';
import 'package:cat_breeds/features/breeds/domain/entities/entities.dart';

extension WeightModelMapper on WeightModel {
  WeightEntity toEntity() {
    return WeightEntity(
      imperial: imperial,
      metric: metric,
    );
  }
}

extension WeightEntityMapper on WeightEntity {
  WeightModel toModel() {
    return WeightModel(
      imperial: imperial,
      metric: metric,
    );
  }
}
