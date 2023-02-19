import '../../../controllers/home_controller.dart';

import '../../../../../../utils/values/export.dart';
import '../../../../../component/widget/base_filter_popupmenu.dart';

class HomeTotalBuyBackFilter extends GetWidget<HomeController> {
  const HomeTotalBuyBackFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Buy Back',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
                color: AppColors.primaryTextColor,
              ),
        ),
        SizedBox(width: 2.w),
        SvgPicture.asset(
          AppIconPath.ar,
          width: 17.w,
          height: 17.h,
          color: AppColors.primaryTextColor,
        ),
        const Spacer(),
        BaseDropDownFilterMenu(
          selectValue: controller.buyBackFilter,
          onFilterMenuChagne: (filter) => controller.onBuyBackFilter(filter),
        ),
      ],
    );
  }
}
