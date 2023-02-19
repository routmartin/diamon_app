import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/values/app_color.dart';
import '../../../../component/widget/base_button.dart';
import '../../../../component/widget/base_textfield.dart';
import '../controllers/verifyotp_controller.dart';

class VerifyOTPView extends GetView<VerifyotpController> {
  const VerifyOTPView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          color: AppColors.lightGray,
          icon: Icon(
            Icons.navigate_before,
            size: 35.w,
          ),
        ),
      ),
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
                  Text('Verification code has been sent to your phone',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 60.h),
                  BaseTextField(
                    hintText: 'Enter Code',
                    validateMsg: 'Please input otp code',
                    isShowsuffix: true,
                    suffixWidget: Text(
                      '50s',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: AppColors.primaryColor),
                    ),
                  ),
                  SizedBox(height: 200.h),
                  BaseButton(
                      hintButton: 'VERIFY',
                      onAction: () {
                        if (controller.formKey.currentState!.validate()) {}
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
