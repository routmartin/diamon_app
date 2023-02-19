import 'package:diamond_app/app/modules/home/views/widget/home_profile_info_preview.dart';

import '../../../../component/widget/base_cached_network_image.dart';

import '../../../../../utils/values/export.dart';
import '../../controllers/home_controller.dart';

class HomeProfileSection extends GetView<HomeController> {
  const HomeProfileSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Appsize.cardPadding),
        child: Row(
          children: [
            Text(
              controller.profile.fullName,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const Spacer(),
            InkWell(
              onTap: () => Get.bottomSheet(
                const HomeProfileInfoPreview(),
                barrierColor: const Color.fromRGBO(0, 0, 0, .4),
                isDismissible: true,
                isScrollControlled: true,
                enableDrag: true,
              ),
              child: Container(
                width: 35.sp,
                height: 35.sp,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.softGray,
                ),
                child: controller.profile.image != ""
                    ? BaseCachedNetworkImage(
                        imageUrl: controller.profile.image ?? "",
                      )
                    : const Icon(
                        Icons.account_circle,
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
