import 'base_loading.dart';
import 'package:get/get.dart';

import 'dialog_loader.dart';

class BaseDialogLoading {
  static final DialogLoader _progressDialog =
      DialogLoader(context: Get.context);

  static void show() {
    _progressDialog.show(
        theme: LoaderTheme.dialogCircle,
        barrierDismissible: false,
        title: const BaseLoading());
  }

  static void dismiss() {
    _progressDialog.close();
  }
}
