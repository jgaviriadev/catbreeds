import 'package:cat_breeds/features/breeds/domain/entities/entities.dart';

class BreedImageEntity {
  final String id;
  final String url;
  final int width;
  final int height;
  final List<BreedEntity>? breeds;

  BreedImageEntity({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
    this.breeds,
  });

  BreedImageEntity copyWith({
    String? id,
    String? url,
    int? width,
    int? height,
    List<BreedEntity>? breeds,
  }) => BreedImageEntity(
    id: id ?? this.id,
    url: url ?? this.url,
    width: width ?? this.width,
    height: height ?? this.height,
    breeds: breeds ?? this.breeds,
  );
}
