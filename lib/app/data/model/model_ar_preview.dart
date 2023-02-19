import 'model_request.dart';

class ModelARPreview {
  ModelARPreview({
    required this.id,
    required this.total,
    required this.status,
    required this.arBalance,
    required this.arRemindDate,
    required this.invoiceNumber,
    required this.customer,
    required this.payment,
  });

  final String id;
  final int total;
  final String status;
  final int arBalance;
  final DateTime arRemindDate;
  final String invoiceNumber;
  final Customer customer;
  final List<Payment> payment;

  factory ModelARPreview.fromJson(Map<String, dynamic> json) => ModelARPreview(
        id: json["id"],
        total: json["total"],
        status: json["status"],
        arBalance: json["arBalance"],
        arRemindDate:
            DateTime.parse(json["arRemindDate"] ?? DateTime.now().toString()),
        invoiceNumber: json["invoiceNumber"],
        customer: Customer.fromJson(json["customer"]),
        payment:
            List<Payment>.from(json["payment"].map((x) => Payment.fromJson(x))),
      );
}

class Payment {
  Payment({
    required this.id,
    required this.paidAmount,
    required this.createdAt,
  });

  final String id;
  final int paidAmount;
  final DateTime createdAt;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        paidAmount: json["paidAmount"],
        createdAt: DateTime.parse(json["createdAt"]),
      );
}
