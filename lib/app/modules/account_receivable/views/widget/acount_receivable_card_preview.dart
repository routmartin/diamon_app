import 'package:diamond_app/app/data/model/model_ar_preview.dart';

import '../../../../component/widget/loading/base_loading.dart';
import '../../../../data/provider/api/base/base.dart';

import '../../../../../utils/values/export.dart';
import '../../../../component/widget/base_account_icon.dart';
import '../../controllers/account_receive_preview_controller.dart';

class AcountReceivableCardPreview extends StatelessWidget {
  final String id;
  const AcountReceivableCardPreview({Key? key, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountReceivePreviewController>(
        init: AccountReceivePreviewController(id),
        builder: (controller) {
          var data = controller.modelArResponse;
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
            child: controller.status == RequestDataStatus.loading
                ? const BaseLoading()
                : SingleChildScrollView(
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
                                title: Row(
                                  children: [
                                    Text(
                                      controller
                                          .modelArResponse!.customer.fullName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    SizedBox(width: 5.sp),
                                    const _GroupStatus()
                                  ],
                                ),
                                subtitle: Padding(
                                  padding: EdgeInsets.only(top: 6.sp),
                                  child: Text(
                                    'No. ${data!.customer.id}',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Icon(Icons.close, size: 24.sp),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 2,
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  "Invoice NO",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 4,
                              child: Text(
                                ': #${data.invoiceNumber}',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 24.h),
                        ...List.generate(
                          data.payment.length,
                          (index) => ArPaymentRecond(data: data, index: index),
                        ).reversed,
                        Row(
                          children: [
                            Flexible(
                              flex: 2,
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  "Total Purchase",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 4,
                              child: Text(
                                ': ${data.total.toString().toUSD()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.primaryColor),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
          );
        });
  }
}

class ArPaymentRecond extends StatelessWidget {
  const ArPaymentRecond({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  final ModelARPreview? data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 26.sp),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: SizedBox(
              width: double.infinity,
              child: Text(
                '#${index + 1}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),
          Flexible(
            flex: 4,
            child: RichText(
              text: TextSpan(
                  text:
                      ': ${data?.payment[index].paidAmount.toString().toUSD()}',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontSize: 16),
                  children: [
                    TextSpan(
                      text: ' - ${data?.payment[index].createdAt.toDate()}',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }
}

class _GroupStatus extends GetWidget<AccountReceivePreviewController> {
  const _GroupStatus();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 9.sp),
      decoration: BoxDecoration(
        color: _checkIsRamainARStatus(controller.modelArResponse!.status)
            ? AppColors.subPrimaryColor
            : AppColors.labelPrimaryGreen,
        borderRadius: BorderRadius.circular(4.sp),
      ),
      child: Text(
        _checkIsRamainARStatus(controller.modelArResponse!.status)
            ? 'Remain ${controller.modelArResponse?.arBalance.toString().toUSD()}'
            : 'Cleared AR',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: _checkIsRamainARStatus(controller.modelArResponse!.status)
                  ? const Color(0XFFF8B400)
                  : const Color(0XFF44A95D),
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
            ),
      ),
    );
  }

  bool _checkIsRamainARStatus(String status) {
    return status == "AR Pay" ? true : false;
  }
}
