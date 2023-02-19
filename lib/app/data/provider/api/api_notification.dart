import '../../model/model_notification.dart';

import 'base/base.dart';

class ApiNotification {
  final ApiBaseHelper _apiHelper = Get.find();

  Future<ModelNotificationResponse> getNotificationListApi(
      Map<String, dynamic>? body) async {
    var response =
        await _apiHelper.getMethodHeader(AppApiKey.notifications, body: body);
    final ModelNotificationResponse data;
    try {
      data = ModelNotificationResponse.fromJson(response.data);
      return data;
    } catch (_) {
      throw ApiBaseHelper.modelMappingErrorObj;
    }
  }
}
