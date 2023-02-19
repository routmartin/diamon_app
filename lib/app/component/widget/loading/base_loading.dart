import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../../../../utils/values/export.dart';

class BaseLoading extends StatelessWidget {
  const BaseLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 100.sp,
      height: 100.sp,
      child: Platform.isAndroid
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
            )
          : const CupertinoActivityIndicator(radius: 14.0),
    );
  }
}
