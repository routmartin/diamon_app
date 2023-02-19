import '../../../../../../utils/values/export.dart';
import '../../../../../component/logic/app_share_logic.dart';
import '../../../../../data/model/model_request.dart';
import 'history_card_preview.dart';

class HistoryItemCard extends StatelessWidget {
  const HistoryItemCard({Key? key, required this.data}) : super(key: key);
  final ModelReqeust data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.bottomSheet(
        HistoryCardPreview(data: data),
        barrierColor: const Color.fromRGBO(0, 0, 0, .4),
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: true,
      ),
      child: Container(
        margin: EdgeInsets.only(
          bottom: 10.w,
          left: Appsize.cardPadding,
          right: Appsize.cardPadding,
        ),
        padding: EdgeInsets.only(
          top: 2.sp,
          bottom: 4.sp,
          right: 10.sp,
          left: 12.sp,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.sp),
          boxShadow: AppDecoration.primaryCardShadow,
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(0.sp),
          minVerticalPadding: 0,
          horizontalTitleGap: 14.sp,
          leading: Container(
              padding: EdgeInsets.all(3.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.sp),
              ),
              child: SvgPicture.asset(_checkIconDisplay())),
          title: AppshareLogic.checkIfReqeustDiscountType(data.type)
              ? Text(
                  data.approval
                      ? "Approved Discount \$ ${data.saleOrder!.manualDiscountAmount}"
                      : "Declined Discount \$ ${data.saleOrder!.manualDiscountAmount}",
                  style: Theme.of(context).textTheme.titleMedium,
                )
              : Text(
                  data.approval
                      ? "Approved to ${data.requestGroup!.name}"
                      : "Declined ${data.requestGroup!.name}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 6.sp),
            child: Text(
              '${data.customer.fullName} No. ${data.customer.id}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          trailing: Text(
            data.updatedAt.toTime(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ),
    );
  }

  String _checkIconDisplay() {
    if (!data.approval) {
      return AppIconPath.reqeustDecline;
    } else if (AppshareLogic.checkIfReqeustDiscountType(data.type)) {
      return AppIconPath.discountApprove;
    }
    return AppIconPath.reqeustApprove;
  }
}
