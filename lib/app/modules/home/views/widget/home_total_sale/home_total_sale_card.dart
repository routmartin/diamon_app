import '../../../../../../utils/values/export.dart';
import 'home_total_sale_filter.dart';
import 'home_total_sale_chart.dart';
import 'home_total_sale_linear.dart';

class HomeTotalSaleCard extends StatelessWidget {
  const HomeTotalSaleCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Appsize.cardPadding),
        padding: EdgeInsets.all(Appsize.primaryPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.white,
          boxShadow: AppDecoration.primaryCardShadow,
        ),
        child: Column(
          children: [
            const HomeTotalSaleFilter(),
            SizedBox(height: 20.h),
            const HomeTotalSaleChart(),
            SizedBox(height: 30.h),
            const HomeTotalSaleLinear(),
            SizedBox(height: 15.h),
          ],
        ),
      ),
    );
  }
}
