import '../../../../utils/values/export.dart';
import '../../../component/widget/loading/base_load_more.dart';
import '../../../data/model/model_notification.dart';
import '../../../data/provider/api/api_notification.dart';

import '../../../data/provider/api/base/base.dart';
import '../../../routes/app_pages.dart';

mixin NotificationState {
  final ApiNotification _apiNotification = Get.find();
  LoadMoreStatus loadMoreStatus = LoadMoreStatus.loading;
  RequestDataStatus status = RequestDataStatus.loading;
  late ModelNotificationResponse modelNotificationResponse;
  late List<ModelNotification> notificationList = [];
  PageStorageKey pageStorageKey = const PageStorageKey('notificationKey');
  int queryOffset = 0;
}

class NotificationController extends GetxController
    with NotificationState, ScrollMixin {
  @override
  void onInit() {
    super.onInit();
    _getNotificationList();
  }

  @override
  Future<void> onTopScroll() async {}

  @override
  Future<void> onEndScroll() async {
    if (loadMoreStatus == LoadMoreStatus.loading) await loadMoreRequestList();
  }

  onRetry() async {
    queryOffset = 0;
    await Future.delayed(const Duration(seconds: 1));
    await _getNotificationList();
  }

  loadMoreRequestList() async {
    try {
      Map<String, dynamic> body = _mapBody();
      modelNotificationResponse =
          await _apiNotification.getNotificationListApi(body);
      if (modelNotificationResponse.data.isNotEmpty) {
        notificationList.addAll(modelNotificationResponse.data);
        status = RequestDataStatus.completed;
        if (notificationList.length < modelNotificationResponse.meta.total) {
          queryOffset += modelNotificationResponse.meta.limit;
          loadMoreStatus = LoadMoreStatus.loading;
        } else {
          loadMoreStatus = LoadMoreStatus.fullLoaded;
        }
      } else {
        status = RequestDataStatus.empty;
      }
    } on ApiError catch (e) {
      switch (e.apiErrorType) {
        case ApiErrorStatus.expireToken:
          loadMoreStatus = LoadMoreStatus.loading;
          loadMoreRequestList();
          break;
        case ApiErrorStatus.noInternet:
          loadMoreStatus = LoadMoreStatus.noConnection;
          break;
        case ApiErrorStatus.somethingWentWrong:
        case ApiErrorStatus.errorRequest:
        default:
          loadMoreStatus = LoadMoreStatus.errorRequest;
          break;
      }
    }
    update();
  }

  onNotificationTab(int index) {
    Get.toNamed(Routes.NOTIFICATIONDDETAIL, arguments: notificationList[index]);
  }

  _getNotificationList() async {
    try {
      queryOffset = 0;
      Map<String, dynamic> body = _mapBody();
      modelNotificationResponse =
          await _apiNotification.getNotificationListApi(body);
      if (modelNotificationResponse.data.isNotEmpty) {
        notificationList = modelNotificationResponse.data;
        status = RequestDataStatus.completed;
        if (notificationList.length < modelNotificationResponse.meta.total) {
          queryOffset += modelNotificationResponse.meta.limit;
          loadMoreStatus = LoadMoreStatus.loading;
        } else {
          loadMoreStatus = LoadMoreStatus.noPaginate;
        }
      } else {
        status = RequestDataStatus.empty;
      }
    } on ApiError catch (e) {
      switch (e.apiErrorType) {
        case ApiErrorStatus.expireToken:
          status = RequestDataStatus.loading;
          _getNotificationList();
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

  _mapBody() {
    Map<String, dynamic> body = {
      "limit": AppConstants.defaultOffset,
      "offset": queryOffset,
      "sort": "DESC",
    };
    body.removeWhere((key, value) => value == null);
    return body;
  }
}
