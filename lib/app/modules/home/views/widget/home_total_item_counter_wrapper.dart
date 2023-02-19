import 'package:diamond_app/utils/values/export.dart';

import '../../../../data/model/model_dashboard.dart';

class HomeTotalItemCounterWrapper extends StatelessWidget {
  final List<ModelProductType> productType;
  const HomeTotalItemCounterWrapper({
    Key? key,
    required this.productType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(productType.length, (index) {
        return _ItemCounter(
          itemName: productType[index].name,
          totalQty: productType[index].totalQty,
          color: PrimaryColorSeries.primaryList[index],
        );
      }),
    );
  }
}

class _ItemCounter extends StatelessWidget {
  const _ItemCounter({
    Key? key,
    required this.itemName,
    required this.totalQty,
    required this.color,
  }) : super(key: key);

  final String itemName;
  final int totalQty;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 12.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(6.sp),
            constraints: const BoxConstraints(minWidth: 35),
            decoration: BoxDecoration(
              color: totalQty > 0 ? color : AppColors.disableContiner,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              totalQty.toString(),
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            itemName,
            textAlign: TextAlign.center,
            style:
                Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 8.sp),
          ),
        ],
      ),
    );
  }
}
