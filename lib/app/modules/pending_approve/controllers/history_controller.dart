import '../../../component/widget/loading/base_load_more.dart';
import '../../../data/model/model_request.dart';

import '../../../../utils/values/export.dart';
import '../../../data/provider/api/api_pending_approve.dart';
import '../../../data/provider/api/base/api_error.dart';

mixin HistoryState {
  final ApiPendingApprove _apiPendingApprove = Get.find();
  PageStorageKey pageStorageKey = const PageStorageKey('historyKey');
  LoadMoreStatus loadMoreStatus = LoadMoreStatus.loading;
  RequestDataStatus status = RequestDataStatus.loading;
  late ModelReqeustResponse modelReqeustResponse;
  late List<ModelReqeust> historyList = [];
  final TextEditingController txtSearcher = TextEditingController(text: null);
}

class HistoryController extends GetxController with HistoryState, ScrollMixin {
  @override
  void onReady() async {
    await _getHistoryList();
    super.onReady();
  }

  int queryOffset = 0;
  int totalRecord = 0;
  String? filterByDate;
  String? filterByType;

  onRetry() async {
    queryOffset = 0;
    await Future.delayed(const Duration(seconds: 1));
    await _getHistoryList();
    _scrollToTop();
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
    await _getHistoryList();
  }

  onSearch() async {
    if (txtSearcher.text.isEmpty) {
      BaseToast.showErorrBaseToast('Please enter customer name!');
      return;
    }
    queryOffset = 0;
    status = RequestDataStatus.loading;
    update();
    _scrollToTop();
    await _getHistoryList();
  }

  onserchClear() async {
    txtSearcher.clear();
    await onRetry();
  }

  loadMoreHistoryList() async {
    try {
      Map<String, dynamic> body = _mapBody();
      modelReqeustResponse =
          await _apiPendingApprove.getReqeustHistoryListApi(body);
      if (modelReqeustResponse.data.isNotEmpty) {
        historyList.addAll(modelReqeustResponse.data);
        if (historyList.length < modelReqeustResponse.meta.total) {
          queryOffset += modelReqeustResponse.meta.limit;
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
          loadMoreHistoryList();
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

  _getHistoryList() async {
    try {
      queryOffset = 0;
      Map<String, dynamic> body = _mapBody();
      modelReqeustResponse =
          await _apiPendingApprove.getReqeustHistoryListApi(body);
      if (modelReqeustResponse.data.isNotEmpty) {
        historyList = modelReqeustResponse.data;
        totalRecord = modelReqeustResponse.meta.total;
        status = RequestDataStatus.completed;
        if (historyList.length < modelReqeustResponse.meta.total) {
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
          _getHistoryList();
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
      "type": filterByType,
      "search": txtSearcher.text.isEmpty ? null : txtSearcher.text,
    };
    body.removeWhere((key, value) => value == null);
    return body;
  }

  void _scrollToTop() async {
    pageStorageKey = PageStorageKey(UniqueKey());
  }

  @override
  Future<void> onEndScroll() async {
    if (loadMoreStatus == LoadMoreStatus.loading) await loadMoreHistoryList();
  }

  @override
  Future<void> onTopScroll() async {}
}
