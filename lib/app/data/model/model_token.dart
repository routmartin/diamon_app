class TokenModel {
  TokenModel({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
      );
}
