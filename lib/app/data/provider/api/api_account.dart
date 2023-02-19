import '../../model/model_profile.dart';
import 'base/api_helper.dart';

class ApiAcount {
  final ApiBaseHelper _apiHelper = Get.find();
  Future<ModelProfile> getProfileApi() async {
    var response = await _apiHelper.getMethodHeader(AppApiKey.profile);
    try {
      return ModelProfile.fromJson(response.data['data']);
    } catch (_) {
      throw ApiBaseHelper.modelMappingErrorObj;
    }
  }
}
