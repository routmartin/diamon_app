import 'model_meta.dart';
import 'model_request.dart';

class ModelNotificationResponse {
  ModelNotificationResponse({
    required this.data,
    required this.meta,
  });

  final List<ModelNotification> data;
  final ModelMeta meta;

  factory ModelNotificationResponse.fromJson(Map<String, dynamic> json) =>
      ModelNotificationResponse(
        data: List<ModelNotification>.from(
            json["data"].map((x) => ModelNotification.fromJson(x))),
        meta: ModelMeta.fromJson(json["meta"]),
      );
}

class ModelNotification {
  ModelNotification({
    required this.id,
    required this.title,
    required this.description,
    required this.group,
    required this.read,
    required this.active,
    required this.createdAt,
    required this.customer,
  });

  final String id;
  final String title;
  final String description;
  final String group;
  final bool read;
  final bool active;
  final DateTime createdAt;
  final Customer? customer;

  factory ModelNotification.fromJson(Map<String, dynamic> json) =>
      ModelNotification(
        id: json["id"],
        title: json["title"],
        description: json["description"] ?? "",
        group: json["group"] ?? "request discount",
        read: json["read"] ?? false,
        active: json["active"] ?? false,
        customer: json["customer"] != null
            ? Customer.fromJson(json["customer"])
            : null,
        createdAt: DateTime.parse(json["createdAt"]),
      );
}
