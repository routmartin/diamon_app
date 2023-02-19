import '../../../utils/values/app_color.dart';
import 'package:flutter/material.dart';

import '../../../utils/values/app_size.dart';

class BaseActionButton extends StatelessWidget {
  const BaseActionButton({
    Key? key,
    required this.label,
    required this.isBorder,
    required this.onAction,
  }) : super(key: key);
  final String label;
  final bool isBorder;
  final Function() onAction;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: onAction,
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.sp),
          decoration: isBorder
              ? BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(
                    Appsize.primaryBorderRadius,
                  ),
                  border: Border.all(
                    width: .5.sp,
                    color: AppColors.primaryColor,
                  ))
              : BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(
                    Appsize.primaryBorderRadius,
                  ),
                ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: isBorder ? AppColors.primaryColor : AppColors.white,
                ),
          ),
        ),
      ),
    );
  }
}
