import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../utils/values/app_color.dart';
import '../../../../component/widget/base_button.dart';
import '../../../../component/widget/base_textfield.dart';
import '../controllers/forget_password_controller.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  const ForgetPasswordView({Key? key}) : super(key: key);

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
                  Text('Enter your phone number',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 60.h),
                  const BaseTextField(
                    hintText: 'Enter phone number',
                    validateMsg: 'Please enter phone number',
                  ),
                  SizedBox(height: 22.h),
                  BaseButton(
                      hintButton: 'NEXT',
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
