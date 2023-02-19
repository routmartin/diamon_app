import 'package:get/get.dart';

import '../../../data/model/model_ar_preview.dart';
import '../../../data/provider/api/api_account_receivable.dart';
import '../../../data/provider/api/base/base.dart';

mixin AccountReceivePreviewState {
  final ApiAccountReciveable _arApi = Get.find();
  RequestDataStatus status = RequestDataStatus.loading;
  ModelARPreview? modelArResponse;
}

class AccountReceivePreviewController extends GetxController
    with AccountReceivePreviewState {
  final String arId;
  AccountReceivePreviewController(this.arId);

  @override
  void onInit() async {
    super.onInit();
    await _getARPreview();
  }

  onRetry() async {
    status = RequestDataStatus.loading;
    update();
    await _getARPreview();
  }

  _getARPreview() async {
    try {
      status = RequestDataStatus.loading;
      update();
      modelArResponse = await _arApi.getARPreview(arId);
      if (modelArResponse!.id.isNotEmpty) {
        status = RequestDataStatus.completed;
      } else {
        status = RequestDataStatus.empty;
      }
    } on ApiError catch (e) {
      switch (e.apiErrorType) {
        case ApiErrorStatus.expireToken:
          status = RequestDataStatus.loading;
          _getARPreview();
          break;
        case ApiErrorStatus.noInternet:
          status = RequestDataStatus.noInternet;
          break;
        default:
          status = RequestDataStatus.failed;
          break;
      }
    }
    update();
  }
}
