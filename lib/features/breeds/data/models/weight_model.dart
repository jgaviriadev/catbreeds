import 'dart:convert';

class WeightModel {
  final String? imperial;
  final String? metric;

  WeightModel({
    this.imperial,
    this.metric,
  });

  factory WeightModel.fromJson(String str) => WeightModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WeightModel.fromMap(Map<String, dynamic> json) => WeightModel(
    imperial: json['imperial'],
    metric: json['metric'],
  );

  Map<String, dynamic> toMap() => {
    'imperial': imperial,
    'metric': metric,
  };
}
