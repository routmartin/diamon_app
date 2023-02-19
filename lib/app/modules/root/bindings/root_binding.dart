import '../../../data/provider/api/api_account_receivable.dart';
import '../../../data/provider/api/api_notification.dart';
import '../../../data/provider/api/api_pending_approve.dart';
import '../../../data/provider/api/base/api_helper.dart';
import '../../../data/provider/storage/storage_token.dart';
import '../../../data/provider/api/api_account.dart';
import '../../../data/provider/api/api_authentication.dart';
import '../../../data/provider/api/api_dashboard.dart';
import '../../pending_approve/controllers/pending_approve_controller.dart';
import '../controllers/root_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    //** */ Api
    Get.put(ApiBaseHelper());
    Get.lazyPut(() => ApiAuthentication(), fenix: true);
    Get.lazyPut(() => ApiAcount());
    Get.lazyPut(() => ApiDashboard());
    Get.lazyPut(() => ApiPendingApprove());
    Get.lazyPut(() => ApiNotification());
    Get.lazyPut(() => ApiAccountReciveable());

    //** */ Storage
    Get.lazyPut(() => StorageToken(), fenix: true);
    //** */ Controller
    Get.lazyPut<RootController>(() => RootController());
    Get.lazyPut(() => PendingApproveController());
  }
}
