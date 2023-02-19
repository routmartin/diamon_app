import '../../../../utils/values/app_constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../model/model_token.dart';
import '../api/api_authentication.dart';

class StorageToken {
  static final GetStorage _storage = GetStorage();
  final ApiAuthentication _apiAuthentication = Get.find();

  static bool isAccessTokenExist() {
    String? token = _storage.read(AppConstants.token);
    if (token != null) {
      return true;
    }
    return false;
  }

  static String readToken() {
    String? token = _storage.read(AppConstants.token);
    if (token != null) {
      return token;
    }
    return "";
  }

  static void deleteToken() {
    _storage.remove(AppConstants.token);
  }

  Future<bool> regenerateToken() async {
    bool isSuccess = false;
    final String refreshToken = _storage.read(AppConstants.refreshToken);
    try {
      final body = {"refresh_token": refreshToken};
      TokenModel token = await _apiAuthentication.regenerateToken(body);
      if (token.accessToken.isNotEmpty) {
        await saveTokenToStorage(token);
        isSuccess = true;
      } else {
        isSuccess = false;
        removeTokenFromStorage();
      }
    } catch (error) {
      removeTokenFromStorage();
      isSuccess = false;
    }
    return isSuccess;
  }

  Future<void> removeTokenFromStorage() async {
    _storage.remove('token');
    _storage.remove('refreshToken');
  }

  Future<void> saveTokenToStorage(TokenModel token) async {
    _storage.write(AppConstants.token, token.accessToken);
    _storage.write(AppConstants.refreshToken, token.refreshToken);
  }
}
