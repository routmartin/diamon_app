import '../../../../utils/values/export.dart';
import '../../../data/model/model_notification.dart';
import '../controllers/notification_controller.dart';

class NotificationDetailView extends StatelessWidget {
  NotificationDetailView({Key? key}) : super(key: key);

  final ModelNotification notification = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Padding(
          padding: EdgeInsets.only(left: Appsize.appbarPadding),
          child: Text(
            'Notification',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
      ),
      body: GetBuilder<NotificationController>(
        builder: (controller) {
          return BaseViewStateHandler(
            onLoad: controller.onRetry,
            requestDataStatus: controller.status,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.all(12.sp),
                    height: Get.height,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification.title,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontSize: 20.sp),
                        ),
                        SizedBox(height: 20.sp),
                        Text(
                          notification.description,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(height: 20.sp),
                        // TODO: we need ar id or discount id within this recond to process event
                        // Row(
                        //   children: [
                        //     BaseActionButton(
                        //       label: 'Decline',
                        //       isBorder: true,
                        //       onAction: () {},
                        //     ),
                        //     SizedBox(width: 8.w),
                        //     BaseActionButton(
                        //       label: 'Approve',
                        //       isBorder: false,
                        //       onAction: () {},
                        //     )
                        //   ],
                        // )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
