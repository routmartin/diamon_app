import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/values/app_color.dart';
import '../../../../utils/values/app_icon_path.dart';
import '../controllers/root_controller.dart';

class RootView extends StatelessWidget {
  const RootView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootController>(
      builder: ((controller) {
        return Scaffold(
          body: controller.listPage[controller.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.white,
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: AppColors.secondLightGray,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: controller.currentIndex,
            onTap: controller.onItemTap,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIconPath.home,
                  width: 30.w,
                  height: 30.h,
                ),
                activeIcon: SvgPicture.asset(
                  AppIconPath.home,
                  width: 30.w,
                  height: 30.h,
                  color: AppColors.primaryColor,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIconPath.account,
                  width: 30.w,
                  height: 30.h,
                ),
                activeIcon: SvgPicture.asset(
                  AppIconPath.account,
                  width: 30.w,
                  height: 30.h,
                  color: AppColors.primaryColor,
                ),
                label: "Confirmation",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIconPath.notification,
                  width: 30.w,
                  height: 30.h,
                ),
                activeIcon: SvgPicture.asset(
                  AppIconPath.notification,
                  width: 30.w,
                  height: 30.h,
                  color: AppColors.primaryColor,
                ),
                label: "Notification",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIconPath.arrow,
                  width: 30.w,
                  height: 30.h,
                ),
                activeIcon: SvgPicture.asset(
                  AppIconPath.arrow,
                  width: 30.w,
                  height: 30.h,
                  color: AppColors.primaryColor,
                ),
                label: "AR",
              ),
            ],
          ),
        );
      }),
    );
  }
}
