import 'package:flutter/cupertino.dart';
import '../../../../../../utils/values/export.dart';
import '../../../controllers/pending_approve_controller.dart';
import 'sliding_segmented_tab.dart';

class CupertinoSlidingSegmentedWrapper extends StatelessWidget {
  const CupertinoSlidingSegmentedWrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PendingApproveController>(builder: ((controller) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        width: double.infinity,
        child: CupertinoSlidingSegmentedControl<int>(
          backgroundColor: AppColors.lightGrayBackground,
          thumbColor: AppColors.white,
          groupValue: controller.currentIndex,
          padding: const EdgeInsets.all(3),
          children: {
            0: SlideingSegmentedTab(
              title: 'Request',
              isOnfocus: controller.currentIndex == 0 ? true : false,
            ),
            1: SlideingSegmentedTab(
              title: 'History',
              isOnfocus: controller.currentIndex == 1 ? true : false,
            ),
          },
          onValueChanged: (index) => controller.onSlidingSegmentedChange(index),
        ),
      );
    }));
  }
}
