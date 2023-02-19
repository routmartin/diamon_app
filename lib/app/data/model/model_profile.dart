class ModelProfile {
  final String? id;
  final String fullName;
  final String? email;
  final String? primaryPhone;
  final String? secondaryPhone;
  final String? idCardNumber;
  final String? gender;
  final String? image;
  final Role role;
  const ModelProfile(
      {this.id,
      required this.fullName,
      this.email,
      this.primaryPhone,
      this.secondaryPhone,
      this.idCardNumber,
      this.gender,
      required this.role,
      this.image});

  static ModelProfile fromJson(Map<String, dynamic> json) {
    return ModelProfile(
        id: json['id'] == null ? null : json['id'] as String,
        fullName: json['fullName'] as String,
        email: json['email'] == null ? null : json['email'] as String,
        primaryPhone: json['primaryPhone'] == null
            ? null
            : json['primaryPhone'] as String,
        secondaryPhone: json['secondaryPhone'] == null
            ? null
            : json['secondaryPhone'] as String,
        idCardNumber: json['idCardNumber'] == null
            ? null
            : json['idCardNumber'] as String,
        gender: json['gender'] == null ? null : json['gender'] as String,
        image: json['image'] == null ? null : json['image'] as String,
        role: Role.fromJson(json["role"]));
  }
}

class Role {
  Role({
    required this.id,
    this.name,
    this.title,
  });

  int id;
  String? name;
  String? title;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        title: json["title"],
      );
}
