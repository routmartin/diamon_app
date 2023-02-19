import '../../model/model_ar.dart';
import '../../model/model_ar_preview.dart';
import 'base/api_helper.dart';

class ApiAccountReciveable {
  final ApiBaseHelper _apiHelper = Get.find();

  Future<ModelArResponse> getARListApi(Map<String, dynamic> body) async {
    var response =
        await _apiHelper.getMethodHeader(AppApiKey.arList, body: body);
    final ModelArResponse data;
    try {
      data = ModelArResponse.fromJson(response.data);
      return data;
    } catch (_) {
      throw ApiBaseHelper.modelMappingErrorObj;
    }
  }

  Future<ModelARPreview> getARPreview(String id) async {
    var response = await _apiHelper.getMethodHeader(AppApiKey.arPreview + id);
    final ModelARPreview data;
    try {
      data = ModelARPreview.fromJson(response.data['data']);
      return data;
    } catch (_) {
      throw ApiBaseHelper.modelMappingErrorObj;
    }
  }

  Future<double> getTotalAr(Map<String, dynamic> body) async {
    var response =
        await _apiHelper.getMethodHeader(AppApiKey.totalAr, body: body);
    final double data;
    try {
      data = double.parse(response.data['data']['totalArBalance'].toString());
      return data;
    } catch (_) {
      throw ApiBaseHelper.modelMappingErrorObj;
    }
  }
}
