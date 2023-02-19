import 'dart:io';

import 'package:diamond_app/utils/service/service_firebase.dart';

import '../../../../component/widget/loading/base_dialog_loading.dart';
import '../../../../data/model/model_token.dart';
import '../../../../data/provider/api/base/api_error.dart';
import '../../../../data/provider/storage/storage_token.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/widget/base_toast.dart';
import '../../../../data/provider/api/api_authentication.dart';
import '../../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final ApiAuthentication _apiAuthentication = Get.find();
  final StorageToken _storageToken = Get.find();

  late final TextEditingController txtAuth;
  late final TextEditingController txtPassword;

  @override
  onInit() {
    super.onInit();
    // text: 'admin0@example.com'
    // txtAuth = TextEditingController(text: "admin0@example.com");
    // txtPassword = TextEditingController(text: "12345");

    txtAuth = TextEditingController();
    txtPassword = TextEditingController();
  }

  onLogin(BuildContext context) async {
    try {
      BaseDialogLoading.show();
      final body = {
        "email": txtAuth.text,
        "password": txtPassword.text,
        "deviceToken": ServiceFirebase.deviceToken,
        "device": _checkPlantform()
      };
      final TokenModel token = await _apiAuthentication.login(body);
      if (token.accessToken.isNotEmpty) {
        await _storageToken.saveTokenToStorage(token);
        BaseDialogLoading.dismiss();
        await ServiceFirebase.instance.initializer();
        Get.offAndToNamed(Routes.MAIN);
      }
    } on ApiError catch (e) {
      BaseDialogLoading.dismiss();
      switch (e.apiErrorType) {
        case ApiErrorStatus.errorRequest:
          BaseToast.showErorrBaseToast(e.apiMessage.message);
          break;
        case ApiErrorStatus.expireToken:
          break;
        case ApiErrorStatus.somethingWentWrong:
          break;
        case ApiErrorStatus.noInternet:
          break;
        default:
      }
    }
  }

  String _checkPlantform() {
    return Platform.isAndroid ? 'android' : 'ios';
  }
}
