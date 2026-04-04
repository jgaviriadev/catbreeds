import 'dart:convert';

import 'package:cat_breeds/features/breeds/data/models/breed_image_model.dart';

class FavoriteModel {
  final int? id;
  final String? userId;
  final String? imageId;
  final String? subId;
  final DateTime? createdAt;
  final BreedImageModel? image;

  FavoriteModel({
    this.id,
    this.userId,
    this.imageId,
    this.subId,
    this.createdAt,
    this.image,
  });

  factory FavoriteModel.fromJson(String str) => FavoriteModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FavoriteModel.fromMap(Map<String, dynamic> json) => FavoriteModel(
    id: json['id'],
    userId: json['user_id'],
    imageId: json['image_id'],
    subId: json['sub_id'],
    createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at']),
    image: json['image'] == null ? null : BreedImageModel.fromMap(json['image']),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'user_id': userId,
    'image_id': imageId,
    'sub_id': subId,
    'created_at': createdAt?.toIso8601String(),
    'image': image?.toMap(),
  };
}
