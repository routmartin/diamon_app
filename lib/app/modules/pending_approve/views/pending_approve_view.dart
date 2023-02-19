import 'widget/slider_segmentedtab/sliding_segmented_wrapper.dart';

import '../../../../utils/values/app_size.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utils/values/app_color.dart';

import '../controllers/pending_approve_controller.dart';
import 'widget/history/history_tab_view_body.dart';
import 'widget/request/reqeust_tab_view_body.dart';

class PendingApproveView extends StatelessWidget {
  const PendingApproveView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: false,
        title: Padding(
          padding: EdgeInsets.only(left: Appsize.appbarPadding),
          child: Text(
            'Pending Approve',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
      ),
      body: GetBuilder<PendingApproveController>(
        builder: ((controller) {
          return Column(
            children: [
              SizedBox(height: 24.h),
              const CupertinoSlidingSegmentedWrapper(),
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  onPageChanged: controller.onSlidingSegmentedChange,
                  children: const [
                    RequestTabviewBody(),
                    HistoryTabViewBody(),
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
