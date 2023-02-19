class ModelMeta {
  ModelMeta({
    required this.limit,
    required this.offset,
    required this.total,
  });

  final int limit;
  final int offset;
  final int total;

  factory ModelMeta.fromJson(Map<String, dynamic> json) => ModelMeta(
        limit: int.parse(json["limit"].toString()),
        offset: int.parse(json["offset"].toString()),
        total: int.parse(json["total"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "limit": limit,
        "offset": offset,
        "total": total,
      };
}
