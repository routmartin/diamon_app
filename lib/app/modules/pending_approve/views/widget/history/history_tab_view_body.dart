import '../../../../../../utils/values/export.dart';
import '../../../../../component/widget/loading/base_load_more.dart';
import '../../../controllers/history_controller.dart';
import '../pending_approval_filter_bottomsheet.dart';
import 'history_item_card.dart';
import 'history_searchbox.dart';
import '../../../../../component/widget/base_total_filter_row.dart';

class HistoryTabViewBody extends StatelessWidget {
  const HistoryTabViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryController>(
        init: HistoryController(),
        autoRemove: false,
        builder: (controller) {
          return Column(
            children: [
              SizedBox(height: 24.h),
              const HistorySearchBox(),
              SizedBox(height: 18.h),
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
                    ignoreSafeArea: false,
                    enableDrag: false,
                    persistent: false),
                totalRecord: controller.totalRecord,
              ),
              SizedBox(height: 12.h),
              Expanded(
                child: BaseViewStateHandler(
                  onLoad: controller.onRetry,
                  requestDataStatus: controller.status,
                  child: CustomScrollView(
                    key: controller.pageStorageKey,
                    controller: controller.scroll,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    slivers: [
                      BaseRefreshIndicator(onRefresh: controller.onRetry),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return HistoryItemCard(
                                data: controller.historyList[index]);
                          },
                          childCount: controller.historyList.length,
                        ),
                      ),
                      BaseLoadMore(
                        onLoadMore: controller.loadMoreHistoryList,
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
}
