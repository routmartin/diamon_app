import 'package:flutter/material.dart';

import '../../../utils/values/app_color.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    Key? key,
    required this.hintButton,
    required this.onAction,
  }) : super(key: key);
  final String hintButton;
  final Function() onAction;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Material(
        color: AppColors.primaryColor,
        child: InkWell(
          splashColor: const Color.fromRGBO(0, 0, 0, 0.122).withOpacity(.3),
          onTap: onAction,
          child: Container(
            width: double.infinity,
            height: 50.h,
            alignment: Alignment.center,
            child: Text(
              hintButton,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
