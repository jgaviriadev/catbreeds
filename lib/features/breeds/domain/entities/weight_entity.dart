class WeightEntity {
  final String? imperial;
  final String? metric;

  WeightEntity({
    this.imperial,
    this.metric,
  });

  WeightEntity copyWith({
    String? imperial,
    String? metric,
  }) => WeightEntity(
    imperial: imperial ?? this.imperial,
    metric: metric ?? this.metric,
  );
}
