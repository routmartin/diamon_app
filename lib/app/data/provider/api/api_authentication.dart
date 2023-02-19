import 'base/api_helper.dart';

import '../../model/model_token.dart';

class ApiAuthentication {
  final ApiBaseHelper _apiHelper = Get.find();

  Future<TokenModel> login(Map<String, dynamic> body) async {
    final Response response =
        await _apiHelper.postMethod(AppApiKey.login, body: body);
    return TokenModel.fromJson(response.data['data']);
  }

  Future<TokenModel> regenerateToken(Map<String, dynamic> body) async {
    final Response response =
        await _apiHelper.postMethod(AppApiKey.login, body: body);
    return TokenModel.fromJson(response.data['data']);
  }

  logout(Map<String, dynamic> body) async {
    final Response response =
        await _apiHelper.postMethod(AppApiKey.logout, body: body);
    return response.data;
  }
}
