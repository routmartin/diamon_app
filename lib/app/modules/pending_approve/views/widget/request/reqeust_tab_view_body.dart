import '../../../../../../utils/values/export.dart';
import '../../../../../component/widget/loading/base_load_more.dart';
import '../../../controllers/request_controller.dart';
import '../pending_approval_filter_bottomsheet.dart';
import 'package:diamond_app/app/data/model/model_request.dart';
import 'request_item_card.dart';
import '../../../../../component/widget/base_total_filter_row.dart';

class RequestTabviewBody extends StatelessWidget {
  const RequestTabviewBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestController>(
        init: RequestController(),
        autoRemove: false,
        builder: (controller) {
          return Column(
            children: [
              SizedBox(height: 30.h),
              BaseTotalFilterRow(
                  onFilter: () => Get.bottomSheet(
                        PendingApprovalFilterBottomsheet(
                          selectedDate: controller.filterByDate,
                          selectedType: controller.filterByType,
                          onApplyFilter: controller.onFilter,
                        ),
                        barrierColor: const Color.fromRGBO(0, 0, 0, .4),
                        isDismissible: true,
                        isScrollControlled: true,
                        enableDrag: false,
                      ),
                  totalRecord: controller.totalRecord),
              SizedBox(height: 12.h),
              Expanded(
                child: BaseViewStateHandler(
                  onLoad: controller.onRetry,
                  requestDataStatus: controller.status,
                  child: CustomScrollView(
                    key: controller.pageStorageKey,
                    controller: controller.scroll,
                    slivers: [
                      BaseRefreshIndicator(onRefresh: controller.onRetry),
                      SliverAnimatedList(
                        key: controller.listKey,
                        initialItemCount: controller.reqeustList.length,
                        itemBuilder: (context, index, animation) {
                          ModelReqeust item = controller.reqeustList[index];
                          return _buildRequestItemCard(
                              item, controller, animation);
                        },
                      ),
                      BaseLoadMore(
                        onLoadMore: controller.loadMoreRequestList,
                        loadMoreStatus: controller.loadMoreStatus,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  _buildRequestItemCard(
      ModelReqeust item, RequestController controller, animation) {
    return FadeTransition(
      opacity: animation,
      child: SizeTransition(
        sizeFactor: animation,
        child: RequestItemCard(
          key: UniqueKey(),
          data: item,
          onApprove: () =>
              controller.onApprove(item, controller, _buildRequestItemCard),
          onReject: () =>
              controller.onReject(item, controller, _buildRequestItemCard),
        ),
      ),
    );
  }
}
