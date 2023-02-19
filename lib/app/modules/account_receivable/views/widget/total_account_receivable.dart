import 'package:diamond_app/utils/values/export.dart';

import '../../controllers/account_receive_controller.dart';

import '../../../../component/widget/base_filter_popupmenu.dart';

class TotalAccountReceivable extends StatelessWidget {
  const TotalAccountReceivable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Appsize.cardPadding),
      padding: EdgeInsets.all(Appsize.primaryPadding),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        boxShadow: AppDecoration.primaryCardShadow,
        borderRadius: BorderRadius.circular(16.sp),
      ),
      child: GetBuilder<AccountReceiveController>(
          init: AccountReceiveController(),
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Total AR',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    SizedBox(width: 10.w),
                    SvgPicture.asset(
                      AppIconPath.ar,
                      width: 17.w,
                      height: 17.h,
                    ),
                    const Spacer(),
                    BaseDropDownFilterMenu(
                      isWhite: true,
                      listFilter: AppString.dateARFilter,
                      selectValue: controller.filterByType,
                      onFilterMenuChagne: (value) =>
                          controller.onTotalARFilter(value),
                    ),
                  ],
                ),
                Text(
                  '\$ ${controller.totalAr}',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.white,
                        fontSize: 24.sp,
                      ),
                ),
              ],
            );
          }),
    );
  }
}
