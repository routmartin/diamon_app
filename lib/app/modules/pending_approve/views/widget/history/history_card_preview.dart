import '../../../../../component/logic/app_share_logic.dart';

import '../../../../../../utils/values/export.dart';
import '../../../../../component/widget/base_account_icon.dart';
import '../../../../../component/widget/base_row_title.dart';
import '../../../../../data/model/model_request.dart';

class HistoryCardPreview extends StatelessWidget {
  const HistoryCardPreview({Key? key, required this.data}) : super(key: key);
  final ModelReqeust data;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(16.sp),
          right: Radius.circular(16.sp),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: 24.sp,
        top: 20.sp,
        right: Appsize.cardPadding,
        left: Appsize.cardPadding,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    minVerticalPadding: 0,
                    horizontalTitleGap: 18.sp,
                    leading: const BaseAccountIcon(),
                    title: Text(
                      data.customer.fullName,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(top: 6.sp),
                      child: Text(
                        'No. ${data.customer.id}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InkWell(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.close,
                      size: 24.sp,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                BaseRowTitle(
                    title: AppshareLogic.checkIfReqeustDiscountType(data.type)
                        ? 'Request Discount'
                        : 'Approved To'),
                Flexible(
                  flex: 3,
                  child: Text(
                    AppshareLogic.checkIfReqeustDiscountType(data.type)
                        ? ': ${data.saleOrder!.manualDiscountAmount}'
                        : ': ${data.requestGroup!.name}',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                )
              ],
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                BaseRowTitle(
                  title: AppshareLogic.checkIfReqeustDiscountType(data.type)
                      ? 'Purchase'
                      : 'Last Purchase',
                ),
                Flexible(
                  flex: 3,
                  child: Text(
                    AppshareLogic.checkIfReqeustDiscountType(data.type)
                        ? ': \$ ${data.saleOrder!.total}'
                        : ': \$ ${data.lastSaleOrder!.total}',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                )
              ],
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                const BaseRowTitle(
                  title: 'Date Request',
                ),
                Flexible(
                  flex: 3,
                  child: Text(
                    ': ${data.createdAt.toDate()}',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                )
              ],
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                BaseRowTitle(
                  title: data.approval ? 'Date Approved' : 'Date Declined',
                ),
                Flexible(
                  flex: 3,
                  child: Text(
                    ': ${data.updatedAt.toDate()}',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
