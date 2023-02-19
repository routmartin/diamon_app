import 'package:diamond_app/utils/extention/app_extension.dart';

import '../../../../component/widget/state_view/state_component.dart';
import '../../../../data/model/model_notification.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/values/app_color.dart';

class NotificationItem extends StatelessWidget {
  final ModelNotification data;
  final Function()? onTab;
  const NotificationItem({
    Key? key,
    required this.data,
    required this.onTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Padding(
        padding: EdgeInsets.only(bottom: 2.w),
        child: ListTile(
          contentPadding: EdgeInsets.all(12.sp),
          title: Text(
            data.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 6.sp),
            child: data.customer != null
                ? Text(
                    '${data.customer?.fullName} No. ${data.customer?.id}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                : const SizedBox(),
          ),
          trailing: Padding(
            padding: EdgeInsets.only(top: 6.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  data.createdAt.toDate(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 6.sp),
                  child: Text(
                    data.createdAt.toTime(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
          leading: Image.asset(
            _checkNotificationGroup(data.group),
            width: 70.w,
            height: 70.h,
          ),
          tileColor: AppColors.white,
        ),
      ),
    );
  }

  String _checkNotificationGroup(String group) {
    switch (group) {
      case 'ar':
        return AppIconPath.iconAr;
      case 'request discount':
        return AppIconPath.iconDiscount;
      default:
        return AppIconPath.iconUpgrade;
    }
  }
}
