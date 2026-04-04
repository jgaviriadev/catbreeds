import 'dart:convert';

class AddFavoriteRequestModel {
  final String? imageId;
  final String? subId;

  AddFavoriteRequestModel({
    this.imageId,
    this.subId,
  });

  factory AddFavoriteRequestModel.fromJson(String str) => AddFavoriteRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddFavoriteRequestModel.fromMap(Map<String, dynamic> json) => AddFavoriteRequestModel(
    imageId: json['image_id'],
    subId: json['sub_id'],
  );

  Map<String, dynamic> toMap() => {
    'image_id': imageId,
    'sub_id': subId,
  };
}
