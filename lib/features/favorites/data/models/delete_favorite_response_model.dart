import 'dart:convert';

class DeleteFavoriteResponseModel {
  final String? message;

  DeleteFavoriteResponseModel({
    this.message,
  });

  factory DeleteFavoriteResponseModel.fromJson(String str) =>
      DeleteFavoriteResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeleteFavoriteResponseModel.fromMap(Map<String, dynamic> json) =>
      DeleteFavoriteResponseModel(
        message: json['message'],
      );

  Map<String, dynamic> toMap() => {
        'message': message,
      };

  bool get isSuccess => message?.toUpperCase() == 'SUCCESS';
}
