// ignore_for_file: use_build_context_synchronously

import 'package:diamond_app/app/modules/pending_approve/controllers/history_controller.dart';

import '../../../component/widget/loading/base_load_more.dart';
import '../../../data/model/model_request.dart';
import '../../../data/provider/api/api_pending_approve.dart';

import '../../../../utils/values/export.dart';
import '../../../data/provider/api/base/api_error.dart';

mixin RequesttState {
  final ApiPendingApprove _apiPendingApprove = Get.find();

  GlobalKey<SliverAnimatedListState> listKey =
      GlobalKey<SliverAnimatedListState>();

  PageStorageKey pageStorageKey = const PageStorageKey('requestKey');
  LoadMoreStatus loadMoreStatus = LoadMoreStatus.loading;
  RequestDataStatus status = RequestDataStatus.loading;
  late ModelReqeustResponse modelReqeustResponse;
  List<ModelReqeust> reqeustList = [];

  int queryOffset = 0;
  int totalRecord = 0;
  String? filterByDate;
  String? filterByType;
}

class RequestController extends GetxController with RequesttState, ScrollMixin {
  @override
  Future<void> onEndScroll() async {
    if (loadMoreStatus == LoadMoreStatus.loading) await loadMoreRequestList();
  }

  @override
  Future<void> onTopScroll() async {}

  @override
  void onInit() {
    super.onInit();
    _getReqeustList();
  }

  onRetry() async {
    queryOffset = 0;
    _scrollToTop();
    await Future.delayed(const Duration(seconds: 1));
    await _getReqeustList();
  }

  onFilter(String? dateFilter, String? typeFilter) async {
    if (dateFilter?.toLowerCase() == filterByDate &&
        typeFilter == filterByType) {
      return;
    }
    queryOffset = 0;
    status = RequestDataStatus.loading;
    update();
    filterByDate = dateFilter?.toLowerCase();
    filterByType = typeFilter;
    _scrollToTop();
    await _getReqeustList();
  }

  onApprove(ModelReqeust itemData, RequestController controller,
      dynamic itemCard) async {
    try {
      BaseDialogLoading.show();
      var data = await _apiPendingApprove.approveRequestApi(itemData.id);
      BaseDialogLoading.dismiss();
      if (data['message'] == 'ok') {
        BaseDialogLoading.dismiss();
        BaseToast.showSuccessBaseToast('Approve succussfully');
        _removeItemFromList(itemData, controller, itemCard);
      }
    } on ApiError catch (e) {
      BaseDialogLoading.dismiss();
      switch (e.apiErrorType) {
        case ApiErrorStatus.expireToken:
          onApprove(itemData, controller, itemCard);
          break;
        case ApiErrorStatus.errorRequest:
          BaseToast.showErorrBaseToast(e.apiMessage.message);
          break;
        case ApiErrorStatus.noInternet:
        case ApiErrorStatus.somethingWentWrong:
        default:
          break;
      }
    }
  }

  onReject(ModelReqeust itemData, RequestController controller,
      dynamic itemCard) async {
    try {
      BaseDialogLoading.show();
      var data = await _apiPendingApprove.rejectRequestApi(itemData.id);
      BaseDialogLoading.dismiss();
      if (data['message'] == 'ok') {
        BaseDialogLoading.dismiss();
        BaseToast.showErorrBaseToast('Reject succussfully');
        _removeItemFromList(itemData, controller, itemCard);
      }
    } on ApiError catch (e) {
      BaseDialogLoading.dismiss();
      switch (e.apiErrorType) {
        case ApiErrorStatus.expireToken:
          onReject(itemData, controller, itemCard);
          break;
        case ApiErrorStatus.errorRequest:
          BaseToast.showErorrBaseToast(e.apiMessage.message);
          break;
        case ApiErrorStatus.noInternet:
        case ApiErrorStatus.somethingWentWrong:
        default:
          break;
      }
    }
  }

  reloadHistoryList() async {
    if (Get.isRegistered<HistoryController>()) {
      await Get.find<HistoryController>().onRetry();
    }
  }

  loadMoreRequestList() async {
    try {
      Map<String, dynamic> body = _mapBody();
      modelReqeustResponse = await _apiPendingApprove.getRequestListApi(body);
      reqeustList.addAll(modelReqeustResponse.data);
      _resetListKey();
      if (reqeustList.length < modelReqeustResponse.meta.total) {
        queryOffset += modelReqeustResponse.meta.limit;
        if (queryOffset > modelReqeustResponse.meta.total) {
          loadMoreStatus = LoadMoreStatus.fullLoaded;
        } else {
          loadMoreStatus = LoadMoreStatus.loading;
        }
      } else {
        loadMoreStatus = LoadMoreStatus.fullLoaded;
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

  _getReqeustList() async {
    try {
      queryOffset = 0;
      Map<String, dynamic> body = _mapBody();
      modelReqeustResponse = await _apiPendingApprove.getRequestListApi(body);
      if (modelReqeustResponse.data.isNotEmpty) {
        _resetListKey();
        reqeustList = modelReqeustResponse.data;
        totalRecord = modelReqeustResponse.meta.total;
        status = RequestDataStatus.completed;
        if (reqeustList.length < modelReqeustResponse.meta.total) {
          queryOffset += modelReqeustResponse.meta.limit;
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
          _getReqeustList();
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
      "filterBy": filterByDate,
      "type": filterByType
    };
    body.removeWhere((key, value) => value == null);
    return body;
  }

  _resetListKey() {
    listKey = GlobalKey<SliverAnimatedListState>();
  }

  _removeItemFromList(
      ModelReqeust itemData, RequestController controller, dynamic itemCard) {
    int removedIndex = reqeustList.indexOf(itemData);
    listKey.currentState?.removeItem(removedIndex,
        (BuildContext context, Animation<double> animation) {
      return itemCard(itemData, controller, animation);
    });
    reqeustList.removeAt(removedIndex);
    if (reqeustList.isEmpty) {
      status = RequestDataStatus.empty;
    }
    queryOffset = reqeustList.length;
    totalRecord -= 1;
    update();
    reloadHistoryList();
  }

  void _scrollToTop() async {
    pageStorageKey = PageStorageKey(UniqueKey());
  }
}
