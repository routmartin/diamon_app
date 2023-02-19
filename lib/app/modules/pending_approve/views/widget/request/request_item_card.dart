import '../../../../../component/logic/app_share_logic.dart';
import '../../../controllers/request_controller.dart';
import '../../../../../../utils/values/export.dart';
import '../../../../../component/widget/base_account_icon.dart';
import '../../../../../component/widget/base_action_button.dart';
import '../../../../../component/widget/base_row_title.dart';
import '../../../../../data/model/model_request.dart';

class RequestItemCard extends GetWidget<RequestController> {
  final ModelReqeust data;
  final Function()? onApprove;
  final Function()? onReject;
  const RequestItemCard(
      {required this.data, this.onApprove, this.onReject, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppshareLogic.checkIfReqeustDiscountType(data.type)
        ? _buildReqeustDiscountCard(context)
        : _buildReqeustUpgradeCard(context);
  }

  _buildReqeustDiscountCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20.w,
        left: Appsize.cardPadding,
        right: Appsize.cardPadding,
      ),
      padding: EdgeInsets.only(
        top: 2.sp,
        bottom: 20.sp,
        right: Appsize.cardPadding,
        left: Appsize.cardPadding,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: AppDecoration.primaryCardShadow,
      ),
      child: Column(
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
            trailing: Image.asset(AppIconPath.iconDiscount),
          ),
          Row(
            children: [
              const BaseRowTitle(title: 'Request Discount'),
              Flexible(
                flex: 3,
                child: Text(
                  ': ${data.saleOrder?.manualDiscountAmount}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              )
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              const BaseRowTitle(title: 'Last Purchase'),
              Flexible(
                flex: 3,
                child: Text(
                  ': \$ ${data.saleOrder?.total}',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
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
          SizedBox(height: 20.h),
          Row(
            children: [
              BaseActionButton(
                label: 'Decline',
                isBorder: true,
                onAction: onReject!,
              ),
              SizedBox(width: 8.w),
              BaseActionButton(
                label: 'Approve',
                isBorder: false,
                onAction: onApprove!,
              )
            ],
          )
        ],
      ),
    );
  }

  _buildReqeustUpgradeCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20.w,
        left: Appsize.cardPadding,
        right: Appsize.cardPadding,
      ),
      padding: EdgeInsets.only(
        top: 2.sp,
        bottom: 20.sp,
        right: Appsize.cardPadding,
        left: Appsize.cardPadding,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: AppDecoration.primaryCardShadow,
      ),
      child: Column(
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
            trailing: Image.asset(AppIconPath.iconUpgrade),
          ),
          Row(
            children: [
              const BaseRowTitle(title: 'Update to'),
              Flexible(
                flex: 3,
                child: Text(
                  ': ${data.requestGroup?.name}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              )
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              const BaseRowTitle(
                title: 'Last Purchase',
              ),
              Flexible(
                flex: 3,
                child: Text(
                  ': \$ ${data.lastSaleOrder?.total}',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
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
          SizedBox(height: 20.h),
          Row(
            children: [
              BaseActionButton(
                  label: 'Decline', isBorder: true, onAction: onReject!),
              SizedBox(width: 8.w),
              BaseActionButton(
                  label: 'Approve', isBorder: false, onAction: onApprove!)
            ],
          )
        ],
      ),
    );
  }
}
