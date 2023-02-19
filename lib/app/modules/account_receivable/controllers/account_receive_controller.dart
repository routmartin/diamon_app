import '../../../component/widget/loading/base_load_more.dart';
import '../../../data/model/model_ar.dart';
import '../../../data/provider/api/api_account_receivable.dart';
import '../../../../utils/values/export.dart';

import '../../../data/provider/api/base/base.dart';

mixin AccountReceiveState {
  final ApiAccountReciveable _arApi = Get.find();
  LoadMoreStatus loadMoreStatus = LoadMoreStatus.loading;
  RequestDataStatus status = RequestDataStatus.loading;
  PageStorageKey pageStorageKey = const PageStorageKey('arkey');
  late ModelArResponse modelArResponse;
  late List<ModelAr> arList = [];
  String? filterByType;
  String? filterTotalAR;
  double totalAr = 0;

  int queryOffset = 0;
  int totalRecord = 0;
}

class AccountReceiveController extends GetxController
    with AccountReceiveState, ScrollMixin {
  @override
  void onReady() async {
    await _getTotalAR();
    await _getARList();
    super.onReady();
  }

  onRetry() async {
    queryOffset = 0;
    await Future.delayed(const Duration(seconds: 1));
    await _getARList();
    _scrollToTop();
  }

  onFilter(String? typeFilter) async {
    if (filterByType == typeFilter) {
      return;
    }
    queryOffset = 0;
    status = RequestDataStatus.loading;
    update();
    filterByType = typeFilter;
    await _getARList();
    _scrollToTop();
  }

  onTotalARFilter(String typeFilter) async {
    if (typeFilter == filterTotalAR) {
      return;
    }
    try {
      filterTotalAR = typeFilter;
      BaseDialogLoading.show();
      await _getTotalAR();
      BaseDialogLoading.dismiss();
    } catch (_) {
      BaseDialogLoading.dismiss();
    }
  }

  loadMoreARList() async {
    try {
      Map<String, dynamic> body = _mapBody();
      modelArResponse = await _arApi.getARListApi(body);
      if (modelArResponse.data.isNotEmpty) {
        arList.addAll(modelArResponse.data);
        if (arList.length < modelArResponse.meta.total) {
          queryOffset += modelArResponse.meta.limit;
          loadMoreStatus = LoadMoreStatus.loading;
        } else {
          loadMoreStatus = LoadMoreStatus.fullLoaded;
        }
      } else {
        loadMoreStatus = LoadMoreStatus.errorRequest;
      }
    } on ApiError catch (e) {
      switch (e.apiErrorType) {
        case ApiErrorStatus.expireToken:
          loadMoreStatus = LoadMoreStatus.loading;
          loadMoreARList();
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

  _getARList() async {
    try {
      queryOffset = 0;
      Map<String, dynamic> body = _mapBody();
      modelArResponse = await _arApi.getARListApi(body);
      if (modelArResponse.data.isNotEmpty) {
        arList = modelArResponse.data;
        totalRecord = modelArResponse.meta.total;
        status = RequestDataStatus.completed;
        if (arList.length < modelArResponse.meta.total) {
          queryOffset += modelArResponse.meta.limit;
          loadMoreStatus = LoadMoreStatus.loading;
        } else {
          loadMoreStatus = LoadMoreStatus.noPaginate;
        }
      } else {
        totalRecord = 0;
        status = RequestDataStatus.empty;
      }
    } on ApiError catch (e) {
      switch (e.apiErrorType) {
        case ApiErrorStatus.expireToken:
          status = RequestDataStatus.loading;
          _getARList();
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

  _getTotalAR() async {
    try {
      Map<String, dynamic> body = _checkFilter();
      body.removeWhere((key, value) => value == null);
      double data = await _arApi.getTotalAr(body);
      if (data >= 0) {
        totalAr = data;
        update();
      }
    } catch (_) {
      BaseToast.showErorrBaseToast('Something went wrong');
    }
  }

  _mapBody() {
    Map<String, dynamic> body = {
      "limit": AppConstants.defaultOffset,
      "offset": queryOffset,
      "sortBy": filterByType,
    };
    body.removeWhere((key, value) => value == null);
    return body;
  }

  _checkFilter() {
    if (filterTotalAR == AppString.dateARFilter[0]) {
      return {'filterBy': null};
    }
    return {'filterBy': filterTotalAR};
  }

  void _scrollToTop() async {
    pageStorageKey = PageStorageKey(UniqueKey());
  }

  @override
  Future<void> onEndScroll() async {
    if (loadMoreStatus == LoadMoreStatus.loading) await loadMoreARList();
  }

  @override
  Future<void> onTopScroll() async {}
}
