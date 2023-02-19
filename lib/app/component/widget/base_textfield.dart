import 'package:diamond_app/utils/values/app_icon_path.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

import '../../../utils/values/app_color.dart';

class BaseTextField extends StatelessWidget {
  const BaseTextField({
    Key? key,
    required this.hintText,
    required this.validateMsg,
    this.textEditingController,
    this.suffixWidget,
    this.isShowsuffix = false,
    this.isEmail = false,
  }) : super(key: key);

  final String hintText;
  final String validateMsg;
  final Widget? suffixWidget;
  final bool isShowsuffix;
  final bool isEmail;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    bool isobscureText = true;

    void showPassword() {
      isobscureText = !isobscureText;
    }

    const OutlineInputBorder borderStyle = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.inputBorderColor, width: .5),
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
    );
    const OutlineInputBorder errorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.errorBorderColor, width: .5),
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
    );
    return StatefulBuilder(builder: (context, setState) {
      return TextFormField(
        controller: textEditingController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validateMsg;
          }
          if (isEmail) {
            return textEditingController!.text.isEmail
                ? null
                : 'Please enter the correct email';
          }
          return null;
        },
        keyboardType: TextInputType.emailAddress,
        showCursor: true,
        obscureText: !isEmail & isobscureText,
        cursorColor: AppColors.black,
        decoration: InputDecoration(
          suffixIcon: !isEmail
              ? GestureDetector(
                  onTap: () {
                    setState(() => showPassword());
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    width: 20.sp,
                    height: 20.sp,
                    child: isobscureText
                        ? Image.asset(AppIconPath.showPassword)
                        : Image.asset(AppIconPath.hidePassword),
                  ),
                )
              : const SizedBox(),
          suffixStyle: const TextStyle(
            color: AppColors.primaryColor,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
          contentPadding: EdgeInsets.fromLTRB(15.sp, 0, 0, 0),
          fillColor: AppColors.white,
          filled: true,
          focusedBorder: borderStyle,
          enabledBorder: borderStyle,
          errorBorder: errorBorder,
          focusedErrorBorder: errorBorder,
          focusColor: AppColors.white,
          hintText: hintText,
          alignLabelWithHint: false,
          hintStyle: const TextStyle(
            color: AppColors.lightGray,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    });
  }
}
