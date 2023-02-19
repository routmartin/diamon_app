import 'model_meta.dart';

class ModelReqeustResponse {
  ModelReqeustResponse({
    required this.data,
    required this.meta,
  });

  final List<ModelReqeust> data;
  final ModelMeta meta;

  factory ModelReqeustResponse.fromJson(Map<String, dynamic> json) =>
      ModelReqeustResponse(
        data: List<ModelReqeust>.from(
            json["data"].map((x) => ModelReqeust.fromJson(x))),
        meta: ModelMeta.fromJson(json["meta"]),
      );
}

class ModelReqeust {
  ModelReqeust({
    required this.id,
    required this.approval,
    required this.type,
    required this.requestGroup,
    required this.lastSaleOrder,
    required this.saleOrder,
    required this.customer,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final bool approval;
  final String type;
  final RequestGroup? requestGroup;
  final SaleOrder? lastSaleOrder;
  final SaleOrder? saleOrder;
  final Customer customer;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory ModelReqeust.fromJson(Map<String, dynamic> json) => ModelReqeust(
        id: json["id"],
        approval: json["approval"] ?? false,
        type: json["type"],
        requestGroup: json['requestGroup'] != null
            ? RequestGroup.fromJson(json['requestGroup'])
            : null,
        lastSaleOrder: json["lastSaleOrder"] != null
            ? SaleOrder.fromJson(json["lastSaleOrder"])
            : null,
        saleOrder: json["saleOrder"] != null
            ? SaleOrder.fromJson(json["saleOrder"])
            : null,
        customer: Customer.fromJson(json["customer"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );
}

class Customer {
  Customer({
    required this.id,
    required this.fullName,
  });

  final String id;
  final String fullName;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        fullName: json["fullName"],
      );
}

class RequestGroup {
  RequestGroup({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory RequestGroup.fromJson(Map<String, dynamic> json) => RequestGroup(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
      );
}

class SaleOrder {
  SaleOrder({
    required this.id,
    required this.total,
    required this.manualDiscountAmount,
    required this.manualDiscountPercentage,
  });

  final String id;
  final double total;
  final double manualDiscountAmount;
  final double manualDiscountPercentage;

  factory SaleOrder.fromJson(Map<String, dynamic> json) => SaleOrder(
      id: json["id"],
      total: double.parse(json["total"].toString()),
      manualDiscountAmount:
          double.parse(json["manualDiscountAmount"].toString()),
      manualDiscountPercentage:
          double.parse(json["manualDiscountPercentage"].toString()));
}
