import '../../../utils/values/app_color.dart';
import 'package:flutter/material.dart';
import '../../../utils/values/app_icon_path.dart';

class BaseTotalFilterRow extends StatelessWidget {
  const BaseTotalFilterRow({
    Key? key,
    required this.onFilter,
    required this.totalRecord,
  }) : super(key: key);

  final Function() onFilter;
  final int totalRecord;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25.h,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: [
          Text(
            'Total $totalRecord',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onFilter,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  AppIconPath.sort,
                  width: 12.w,
                  height: 12.h,
                ),
                SizedBox(width: 4.sp),
                GestureDetector(
                  child: Text(
                    'Filter',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                  ),
                ),
                SizedBox(width: 4.sp),
              ],
            ),
          )
        ],
      ),
    );
  }
}
