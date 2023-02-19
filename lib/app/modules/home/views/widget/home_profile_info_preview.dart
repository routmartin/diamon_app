import 'package:diamond_app/app/modules/home/controllers/home_controller.dart';
import 'package:diamond_app/utils/values/export.dart';

import '../../../../component/widget/base_button.dart';
import '../../../../component/widget/base_cached_network_image.dart';

class HomeProfileInfoPreview extends StatelessWidget {
  const HomeProfileInfoPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      double iconSize = 50.sp;
      var profile = controller.profile;
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: iconSize,
                height: iconSize,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.softGray,
                ),
                child: profile.image != ""
                    ? BaseCachedNetworkImage(
                        imageUrl: profile.image ?? "",
                      )
                    : Icon(
                        Icons.account_circle,
                        size: iconSize,
                      ),
              ),
              SizedBox(height: 12.sp),
              _BuildProfileInfoLabelText(
                label: "Full Name",
                text: profile.fullName,
              ),
              _BuildProfileInfoLabelText(
                label: "Email",
                text: profile.email ?? "",
              ),
              _BuildProfileInfoLabelText(
                label: "Primary Phone",
                text: profile.primaryPhone ?? "",
              ),
              _BuildProfileInfoLabelText(
                label: "Secondary Phone",
                text: profile.secondaryPhone ?? "",
              ),
              _BuildProfileInfoLabelText(
                label: "Role",
                text: profile.role.title ?? "",
              ),
              SizedBox(height: 24.sp),
              BaseButton(hintButton: 'LOG OUT', onAction: controller.logOut),
            ],
          ),
        ),
      );
    });
  }
}

class _BuildProfileInfoLabelText extends StatelessWidget {
  const _BuildProfileInfoLabelText({
    Key? key,
    required this.label,
    required this.text,
  }) : super(key: key);

  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.sp),
      width: Get.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: SizedBox(
                width: Get.width,
                child:
                    Text(label, style: Theme.of(context).textTheme.titleSmall)),
          ),
          Flexible(
            flex: 3,
            child: Text(
              ": $text",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
