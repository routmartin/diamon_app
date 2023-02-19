import '../../../../../component/widget/base_filter_popupmenu.dart';
import '../../../controllers/home_controller.dart';
import '../../../../../../utils/values/export.dart';

class HomeTotalSaleFilter extends GetView<HomeController> {
  const HomeTotalSaleFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Total Sale',
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
          selectValue: controller.totalSaleFilter,
          onFilterMenuChagne: (filter) => controller.onTotalSaleFitler(filter),
        ),
      ],
    );
  }
}
