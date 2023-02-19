import '../../../controllers/home_controller.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../../../utils/values/export.dart';

class HomeTotalSaleLinear extends GetView<HomeController> {
  const HomeTotalSaleLinear({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        id: "totalSale",
        builder: (controller) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(
              controller.totalSale.productType!.length,
              (index) {
                var productType = controller.totalSale.productType?[index];
                return _AmountCounter(
                  itemName: productType!.name,
                  totalAmount: productType.totalAmount ?? 0,
                  color: PrimaryColorSeries.primaryList[index],
                  percentage: _calculatePercent(
                    controller.totalSale.totalAmount ?? 0,
                    productType.totalAmount,
                  ),
                );
              },
            ),
          );
        });
  }
}

double _calculatePercent(double totalAmount, totalItemAmount) {
  if (totalAmount == 0 && totalItemAmount == 0) return 0.0;
  double persentage = (totalItemAmount * 100) / totalAmount;
  return double.parse(persentage.toStringAsFixed(2));
}

class _AmountCounter extends StatelessWidget {
  const _AmountCounter(
      {Key? key,
      required this.itemName,
      required this.totalAmount,
      required this.color,
      required this.percentage})
      : super(key: key);

  final String itemName;
  final double totalAmount;
  final Color color;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '\$${totalAmount.toStringAsFixed(2)}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 16.sp,
                ),
          ),
          SizedBox(height: 5.sp),
          Text(
            itemName,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: AppColors.primaryTextColor),
          ),
          SizedBox(height: 9.h),
          LinearPercentIndicator(
            lineHeight: 14.0,
            percent: percentage / 100,
            backgroundColor: const Color(0XFFE2E6FF),
            progressColor: color,
            barRadius: Radius.circular(9.sp),
          ),
        ],
      ),
    );
  }
}
