import '../../model/model_request.dart';
import 'base/api_helper.dart';

class ApiPendingApprove {
  final ApiBaseHelper _apiHelper = Get.find();

  Future<ModelReqeustResponse> getRequestListApi(
      Map<String, dynamic> body) async {
    var response =
        await _apiHelper.getMethodHeader(AppApiKey.request, body: body);
    final ModelReqeustResponse data;
    try {
      data = ModelReqeustResponse.fromJson(response.data);
      return data;
    } catch (_) {
      throw ApiBaseHelper.modelMappingErrorObj;
    }
  }

  approveRequestApi(String id) async {
    Response response =
        await _apiHelper.putMethodHeader(AppApiKey.approveRequest + id);
    return response.data;
  }

  rejectRequestApi(String id) async {
    Response response = await _apiHelper
        .putMethodHeader(AppApiKey.rejectRequest + id.toString());
    try {
      return response.data;
    } catch (_) {
      throw ApiBaseHelper.modelMappingErrorObj;
    }
  }

  Future<ModelReqeustResponse> getReqeustHistoryListApi(
      Map<String, dynamic> body) async {
    var response =
        await _apiHelper.getMethodHeader(AppApiKey.history, body: body);
    final ModelReqeustResponse data;
    try {
      data = ModelReqeustResponse.fromJson(response.data);
      return data;
    } catch (_) {
      throw ApiBaseHelper.modelMappingErrorObj;
    }
  }
}
