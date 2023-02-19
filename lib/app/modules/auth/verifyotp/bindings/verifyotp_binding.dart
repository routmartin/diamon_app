import 'package:get/get.dart';

import '../controllers/verifyotp_controller.dart';

class VerifyotpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyotpController>(
      () => VerifyotpController(),
    );
  }
}
