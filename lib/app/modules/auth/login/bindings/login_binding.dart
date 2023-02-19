import '../../../../data/provider/api/base/base.dart';
import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiBaseHelper());
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
