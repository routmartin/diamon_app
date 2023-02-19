import '../../pending_approve/controllers/pending_approve_controller.dart';

import '../../account_receivable/views/account_receive_view.dart';
import '../../pending_approve/views/pending_approve_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/views/home_view.dart';
import '../../notification/views/notification_view.dart';

class RootController extends GetxController {
  int currentIndex = 0;

  final List<Widget> listPage = [
    const HomeView(),
    const PendingApproveView(),
    const NotificationView(),
    const AccountReceiveView(),
  ];

  onItemTap(int index) {
    if (index == 1) {
      Get.find<PendingApproveController>().onPendingApprovalTab();
    }
    currentIndex = index;
    update();
  }
}
