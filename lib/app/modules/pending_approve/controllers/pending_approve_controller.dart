import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PendingApproveController extends GetxController {
  int currentIndex = 0;
  PageController pageController = PageController();

  onSlidingSegmentedChange(int? index) {
    currentIndex = index!;
    pageController.jumpToPage(currentIndex);
    update();
  }

  onPendingApprovalTab() {
    pageController = PageController(initialPage: currentIndex);
  }
}
