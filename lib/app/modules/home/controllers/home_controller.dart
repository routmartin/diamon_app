import 'package:diamond_app/app/data/provider/api/api_authentication.dart';
import 'package:diamond_app/app/data/provider/storage/storage_token.dart';

import '../../../../utils/service/service_firebase.dart';
import '../../../data/model/model_dashboard.dart';
import '../../../data/model/model_profile.dart';
import '../../../data/provider/api/api_account.dart';
import '../../../data/provider/api/api_dashboard.dart';
import '../../../data/provider/api/base/api_error.dart';
import '../../../../utils/values/export.dart';

import '../../../data/model/model_pie_data.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../../routes/app_pages.dart';

mixin HomeState {
  final ApiAcount _acountApi = Get.find();
  final ApiDashboard _apiDashboard = Get.find();
  final ApiAuthentication _apiAuthentication = Get.find();
  final StorageToken _storageToken = Get.find();

  late List<charts.Series<ModelPieData, String>> seriesList;
  late bool animate;
  late ModelProfile profile;
  late ModelDashboard totalSale;
  late ModelDashboard buyBack;
  RequestDataStatus status = RequestDataStatus.loading;

  String? totalSaleFilter;
  String? buyBackFilter;
}

class HomeController extends GetxController with HomeState {
  @override
  void onInit() {
    super.onInit();
    animate = true;
    _initalizeRequest();
  }

  onRetry() async {
    await Future.delayed(const Duration(seconds: 1));
    await _initalizeRequest();
  }

  onTotalSaleFitler(String filter) async {
    if (totalSaleFilter == filter) {
      return;
    }
    totalSaleFilter = filter;
    Map<String, String> body = {'filterBy': totalSaleFilter!.toLowerCase()};
    totalSale = await _apiDashboard.getTotalSaleApi(body);
    if (totalSale.totalAmount != null) {
      seriesList = _createPieData();
    }
    update(['totalSale']);
  }

  onBuyBackFilter(String filter) async {
    if (buyBackFilter == filter) {
      return;
    }
    buyBackFilter = filter;
    Map<String, String> body = {'filterBy': buyBackFilter!.toLowerCase()};
    buyBack = await _apiDashboard.getBuyBackApi(body);
    if (buyBack.totalAmount != null) {
      update(['backBack']);
    }
  }

  logOut() async {
    BaseDialogLoading.show();
    Map<String, String> body = {
      "deviceToken": ServiceFirebase.deviceToken!,
    };
    var meesge = await _apiAuthentication.logout(body);
    if (meesge['message'] == 'ok') {
      Get.back();
      await _storageToken.removeTokenFromStorage();
      BaseDialogLoading.dismiss();
      Get.offAndToNamed(Routes.LOGIN);
    }
  }

  _initalizeRequest() async {
    totalSaleFilter = AppString.dateFilter[0];
    buyBackFilter = AppString.dateFilter[0];
    try {
      await _getProfile();
      await _getTotalSale();
      await _getBuyBack();
      status = RequestDataStatus.completed;
    } on ApiError catch (e) {
      switch (e.apiErrorType) {
        case ApiErrorStatus.expireToken:
          status = RequestDataStatus.loading;
          _initalizeRequest();
          break;
        case ApiErrorStatus.noInternet:
          status = RequestDataStatus.noInternet;
          break;
        case ApiErrorStatus.somethingWentWrong:
        case ApiErrorStatus.errorRequest:
        default:
          status = RequestDataStatus.failed;
          break;
      }
    }
    update();
  }

  Future<void> _getProfile() async {
    profile = await _acountApi.getProfileApi();
  }

  Future<void> _getTotalSale() async {
    Map<String, String> body = {'filterBy': totalSaleFilter!.toLowerCase()};
    totalSale = await _apiDashboard.getTotalSaleApi(body);
    if (totalSale.totalAmount != null) {
      seriesList = _createPieData();
    }
  }

  Future<void> _getBuyBack() async {
    Map<String, String> body = {'filterBy': buyBackFilter!.toLowerCase()};
    buyBack = await _apiDashboard.getBuyBackApi(body);
  }

  List<charts.Series<ModelPieData, String>> _createPieData() {
    final data = List.generate(totalSale.productType!.length, (index) {
      final ModelProductType item = totalSale.productType![index];
      return ModelPieData(
        item.name,
        double.parse(item.totalQty.toString()),
        item.totalQty,
      );
    });

    return [
      charts.Series<ModelPieData, String>(
        id: 'diamond',
        domainFn: (ModelPieData data, _) => data.itemName,
        measureFn: (ModelPieData data, _) =>
            data.totalQty > 0 ? data.totalQty : 1,
        colorFn: (datum, index) => charts.ColorUtil.fromDartColor(
          datum.totalQty > 0
              ? PrimaryColorSeries.primaryList[index!]
              : AppColors.disableContiner,
        ),
        data: data,
      )
    ];
  }
}
