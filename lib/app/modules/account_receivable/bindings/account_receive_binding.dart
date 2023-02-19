import 'package:get/get.dart';

import '../controllers/account_receive_controller.dart';

class AccountReceiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountReceiveController>(
      () => AccountReceiveController(),
    );
  }
}
