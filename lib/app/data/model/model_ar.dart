import 'model_meta.dart';

import 'model_request.dart';

class ModelArResponse {
  ModelArResponse({
    required this.data,
    required this.meta,
  });

  final List<ModelAr> data;
  final ModelMeta meta;

  factory ModelArResponse.fromJson(Map<String, dynamic> json) =>
      ModelArResponse(
        data: List<ModelAr>.from(json["data"].map((x) => ModelAr.fromJson(x))),
        meta: ModelMeta.fromJson(json["meta"]),
      );
}

class ModelAr {
  ModelAr({
    required this.id,
    required this.total,
    required this.status,
    required this.arBalance,
    required this.arRemindDate,
    required this.invoiceNumber,
    required this.customer,
    required this.lastPayment,
  });

  final String id;
  final int total;
  final String status;
  final double arBalance;
  final DateTime? arRemindDate;
  final String invoiceNumber;
  final Customer customer;
  final int lastPayment;

  factory ModelAr.fromJson(Map<String, dynamic> json) => ModelAr(
        id: json["id"],
        total: json["total"],
        status: json["status"],
        arBalance: double.parse(json["arBalance"].toString()),
        arRemindDate: json["lastPaymentDate"] != null
            ? DateTime.parse(json["lastPaymentDate"])
            : null,
        invoiceNumber: json["invoiceNumber"],
        customer: Customer.fromJson(json["customer"]),
        lastPayment: json["lastPayment"],
      );
}
