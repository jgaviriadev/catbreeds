import 'dart:convert';

class AddFavoriteResponseModel {
  final String? message;
  final int? id;

  AddFavoriteResponseModel({
    this.message,
    this.id,
  });

  factory AddFavoriteResponseModel.fromJson(String str) =>
      AddFavoriteResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddFavoriteResponseModel.fromMap(Map<String, dynamic> json) =>
      AddFavoriteResponseModel(
        message: json['message'],
        id: json['id'],
      );

  Map<String, dynamic> toMap() => {
        'message': message,
        'id': id,
      };

  bool get isSuccess => message?.toUpperCase() == 'SUCCESS';
}
