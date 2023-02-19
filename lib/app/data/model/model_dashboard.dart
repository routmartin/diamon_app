class ModelDashboard {
  final double? totalAmount;
  final List<ModelProductType>? productType;
  const ModelDashboard({this.totalAmount, this.productType});

  static ModelDashboard fromJson(Map<String, Object?> json) {
    return ModelDashboard(
        totalAmount: json['totalAmount'] == null
            ? null
            : double.parse(json['totalAmount'].toString()),
        productType: json['productType'] == null
            ? null
            : (json['productType'] as List)
                .map<ModelProductType>((data) =>
                    ModelProductType.fromJson(data as Map<String, Object?>))
                .toList());
  }
}

class ModelProductType {
  final int? id;
  final String name;
  final int totalQty;
  final double? totalAmount;
  final int? sortOrder;
  const ModelProductType(
      {this.id,
      required this.name,
      required this.totalQty,
      this.totalAmount,
      this.sortOrder});

  static ModelProductType fromJson(Map<String, Object?> json) {
    return ModelProductType(
        id: json['id'] == null ? null : json['id'] as int,
        name: json['name'] as String,
        totalQty: json['totalQty'] as int,
        totalAmount: json['totalAmount'] == null
            ? null
            : double.parse(json['totalAmount'].toString()),
        sortOrder: json['sortOrder'] == null ? null : json['sortOrder'] as int);
  }
}
