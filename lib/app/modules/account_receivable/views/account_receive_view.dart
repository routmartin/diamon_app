import '../../../component/widget/loading/base_load_more.dart';
import 'widget/account_receive_filter_bottomsheet.dart';
import '../../../../utils/values/export.dart';
import '../../../component/widget/base_total_filter_row.dart';
import '../controllers/account_receive_controller.dart';
import 'widget/account_receivable_item_card.dart';
import 'widget/total_account_receivable.dart';

class AccountReceiveView extends StatelessWidget {
  const AccountReceiveView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Padding(
          padding: EdgeInsets.only(left: Appsize.appbarPadding),
          child: Text(
            'Account Receivable',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
      ),
      body: GetBuilder<AccountReceiveController>(
          init: AccountReceiveController(),
          autoRemove: false,
          builder: (controller) {
            return Column(
              children: [
                SizedBox(height: Appsize.cardPadding),
                const TotalAccountReceivable(),
                SizedBox(height: 30.h),
                BaseTotalFilterRow(
                  onFilter: () => Get.bottomSheet(
                    AccountReceiveFilterBottomSheet(
                      filterByReqeustGroup: controller.filterByType,
                      onApplyFilter: controller.onFilter,
                    ),
                    barrierColor: const Color.fromRGBO(0, 0, 0, .4),
                    isDismissible: true,
                    ignoreSafeArea: false,
                    enableDrag: false,
                  ),
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
                      slivers: [
                        BaseRefreshIndicator(onRefresh: controller.onRetry),
                        SliverList(
                            delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return AccountReceivableItemcard(
                              data: controller.arList[index],
                            );
                          },
                          childCount: controller.arList.length,
                        )),
                        BaseLoadMore(
                          onLoadMore: controller.loadMoreARList,
                          loadMoreStatus: controller.loadMoreStatus,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}
