import '../../model/model_dashboard.dart';
import 'base/api_helper.dart';

class ApiDashboard {
  final ApiBaseHelper _apiHelper = Get.find();
  Future<ModelDashboard> getTotalSaleApi(Map<String, String> body) async {
    var response =
        await _apiHelper.getMethodHeader(AppApiKey.saleOrder, body: body);
    final ModelDashboard data;
    try {
      data = ModelDashboard.fromJson(response.data['data']);
      return data;
    } catch (_) {
      throw ApiBaseHelper.modelMappingErrorObj;
    }
  }

  Future<ModelDashboard> getBuyBackApi(Map<String, String>? body) async {
    var response =
        await _apiHelper.getMethodHeader(AppApiKey.buyBack, body: body);
    final ModelDashboard data;
    try {
      data = ModelDashboard.fromJson(response.data['data']);
      return data;
    } catch (_) {
      throw ApiBaseHelper.modelMappingErrorObj;
    }
  }
}
