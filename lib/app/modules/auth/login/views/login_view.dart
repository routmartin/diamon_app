import '../../../../../utils/values/app_color.dart';
import '../../../../../utils/values/app_icon_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/widget/base_button.dart';
import '../../../../component/widget/base_textfield.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: Get.height * .1),
                  SvgPicture.asset(
                    AppIconPath.appLogo,
                    width: 100.sp,
                    height: 100.sp,
                  ),
                  const SizedBox(height: 16),
                  SvgPicture.asset(
                    AppIconPath.lindaLogo,
                    height: 36.sp,
                  ),
                  SizedBox(height: Get.height * .08),
                  BaseTextField(
                    textEditingController: controller.txtAuth,
                    hintText: 'Enter email',
                    validateMsg: 'Please enter your email',
                    isEmail: true,
                  ),
                  SizedBox(height: 16.sp),
                  BaseTextField(
                    textEditingController: controller.txtPassword,
                    hintText: 'Password',
                    validateMsg: 'Please enter password password',
                  ),

                  /// comment as now we don't have format password api yet
                  // Container(
                  //   width: double.infinity,
                  //   padding: const EdgeInsets.symmetric(vertical: 10),
                  //   child: const InkWell(
                  //     child: Text(
                  //       'Forgot Password',
                  //       textAlign: TextAlign.end,
                  //       style: TextStyle(
                  //         color: AppColors.primaryColor,
                  //         fontWeight: FontWeight.w400,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 22.h),
                  BaseButton(
                      hintButton: 'LOG IN',
                      onAction: () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.onLogin(context);
                        }
                      }),
                  SizedBox(height: 22.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
