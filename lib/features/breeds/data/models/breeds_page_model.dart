import 'package:cat_breeds/features/breeds/data/models/models.dart';

/// Model representing a paginated response of breeds with metadata
class BreedsPageModel {
  final List<BreedModel> breeds;
  final int totalCount;

  BreedsPageModel({
    required this.breeds,
    required this.totalCount,
  });
}
