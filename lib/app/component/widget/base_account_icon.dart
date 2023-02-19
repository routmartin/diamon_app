import 'package:flutter/material.dart';

import '../../../utils/values/app_color.dart';

class BaseAccountIcon extends StatelessWidget {
  const BaseAccountIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36.w,
      height: 36.h,
      decoration: BoxDecoration(
        color: AppColors.dartGray,
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Icon(
        Icons.person,
        color: AppColors.white,
      ),
    );
  }
}
