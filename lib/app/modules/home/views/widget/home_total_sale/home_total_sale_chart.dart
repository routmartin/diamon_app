import '../../../controllers/home_controller.dart';
import '../../../../../../utils/values/app_color.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:get/get.dart';

import '../home_total_item_counter_wrapper.dart';

class HomeTotalSaleChart extends StatelessWidget {
  const HomeTotalSaleChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: 'totalSale',
      builder: (controller) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: Get.height / 3,
              width: double.infinity,
              child: charts.PieChart<String>(
                controller.seriesList,
                animate: controller.animate,
                layoutConfig: charts.LayoutConfig(
                  leftMarginSpec: charts.MarginSpec.fixedPixel(0),
                  topMarginSpec: charts.MarginSpec.fixedPixel(0),
                  rightMarginSpec: charts.MarginSpec.fixedPixel(0),
                  bottomMarginSpec: charts.MarginSpec.fixedPixel(0),
                ),
                defaultRenderer: charts.ArcRendererConfig(
                  arcRatio: .35,
                  strokeWidthPx: 0,
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  "\$${controller.totalSale.totalAmount!.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                SizedBox(height: 7.h),
                HomeTotalItemCounterWrapper(
                  productType: controller.totalSale.productType!,
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
