import 'dart:convert';

import 'package:cat_breeds/features/breeds/data/models/models.dart';

class BreedImageModel {
  final List<BreedModel>? breeds;
  final String? id;
  final String? url;
  final int? width;
  final int? height;

  BreedImageModel({
    this.breeds,
    this.id,
    this.url,
    this.width,
    this.height,
  });

  factory BreedImageModel.fromJson(String str) => BreedImageModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BreedImageModel.fromMap(Map<String, dynamic> json) => BreedImageModel(
    breeds: json['breeds'] == null ? [] : List<BreedModel>.from(json['breeds']!.map((x) => BreedModel.fromMap(x))),
    id: json['id'],
    url: json['url'],
    width: json['width'],
    height: json['height'],
  );

  Map<String, dynamic> toMap() => {
    'breeds': breeds == null ? [] : List<dynamic>.from(breeds!.map((x) => x.toMap())),
    'id': id,
    'url': url,
    'width': width,
    'height': height,
  };
}
