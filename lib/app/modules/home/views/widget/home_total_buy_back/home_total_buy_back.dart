import 'package:diamond_app/app/modules/home/controllers/home_controller.dart';

import '../../../../../../utils/values/export.dart';

import '../home_total_item_counter_wrapper.dart';
import 'home_total_buy_back_filter.dart';

class HomeTotalBuyBack extends StatelessWidget {
  const HomeTotalBuyBack({
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
        child: GetBuilder<HomeController>(
          id: 'backBack',
          builder: (controller) {
            return Column(
              children: [
                const HomeTotalBuyBackFilter(),
                Row(
                  children: [
                    Text(
                      '\$ ${controller.buyBack.totalAmount?.toStringAsFixed(2)}',
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                                fontSize: 20.sp,
                              ),
                    ),
                    const Spacer(),
                    HomeTotalItemCounterWrapper(
                      productType: controller.buyBack.productType!,
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
