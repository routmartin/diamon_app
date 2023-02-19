import '../../../../utils/values/export.dart';

import '../../../component/widget/loading/base_load_more.dart';
import '../controllers/notification_controller.dart';
import 'widget/notification_item.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(left: Appsize.appbarPadding),
          child: Text(
            'Notification',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
      ),
      body: GetBuilder<NotificationController>(
        init: NotificationController(),
        autoRemove: false,
        builder: (controller) {
          return BaseViewStateHandler(
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
                      return NotificationItem(
                        onTab: () => controller.onNotificationTab(index),
                        data: controller.notificationList[index],
                      );
                    },
                    childCount: controller.notificationList.length,
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 10.sp)),
                BaseLoadMore(
                  onLoadMore: controller.loadMoreRequestList,
                  loadMoreStatus: controller.loadMoreStatus,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
