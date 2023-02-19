import '../../../../component/widget/base_account_icon.dart';
import '../../../../data/model/model_ar.dart';

import '../../../../../utils/values/export.dart';
import '../../../../component/widget/base_row_title.dart';
import 'acount_receivable_card_preview.dart';

class AccountReceivableItemcard extends StatelessWidget {
  const AccountReceivableItemcard({Key? key, required this.data})
      : super(key: key);

  final ModelAr data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.bottomSheet(
        AcountReceivableCardPreview(id: data.id),
        barrierColor: const Color.fromRGBO(0, 0, 0, .4),
        isDismissible: true,
        isScrollControlled: true,
        enableDrag: true,
      ),
      child: Container(
        alignment: Alignment.center,
        height: 240.h,
        margin: EdgeInsets.only(
          bottom: 10.w,
          left: Appsize.cardPadding,
          right: Appsize.cardPadding,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: AppDecoration.primaryCardShadow,
        ),
        child: Row(
          children: [
            Container(
              width: 12.w,
              decoration: BoxDecoration(
                color: _checkIsRamainARStatus(data.status)
                    ? AppColors.primaryColor
                    : AppColors.seconderyColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.sp),
                  bottomLeft: Radius.circular(8.sp),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 2.sp,
                  right: 12.sp,
                  left: Appsize.cardPadding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
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
                      trailing: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.sp, horizontal: 9.sp),
                        decoration: BoxDecoration(
                          color: _checkIsRamainARStatus(data.status)
                              ? AppColors.subPrimaryColor
                              : AppColors.labelPrimaryGreen,
                          borderRadius: BorderRadius.circular(4.sp),
                        ),
                        child: Text(
                          _checkIsRamainARStatus(data.status)
                              ? 'Remain ${data.arBalance.toString().toUSD()}'
                              : 'Cleared AR',
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: _checkIsRamainARStatus(data.status)
                                        ? const Color(0XFFF8B400)
                                        : const Color(0XFF44A95D),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                  ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        BaseRowTitle(
                          title: _checkIsRamainARStatus(data.status)
                              ? 'Last Payment'
                              : 'Payment',
                        ),
                        Flexible(
                          flex: 3,
                          child: Text(
                            ': ${data.lastPayment.toString().toUSD()}',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        const BaseRowTitle(
                          title: 'Invioce No',
                        ),
                        Flexible(
                          flex: 3,
                          child: Text(
                            ': #${data.invoiceNumber}',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        const BaseRowTitle(title: 'Payment Date'),
                        Flexible(
                          flex: 3,
                          child: Text(
                            ': ${data.arRemindDate?.toDate() ?? 'N/A'}',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseRowTitle(
                          title: 'Total Purchase',
                        ),
                        Flexible(
                          flex: 3,
                          child: Text(
                            ': ${data.total.toString().toUSD()}',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _checkIsRamainARStatus(String status) {
    return status == "AR Pay" ? true : false;
  }
}
