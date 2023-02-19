import 'widget/home_total_buy_back/home_total_buy_back.dart';
import '../../../../utils/values/export.dart';
import '../controllers/home_controller.dart';
import 'widget/home_total_sale/home_total_sale_card.dart';
import 'widget/home_profile_section.dart';
import 'widget/home_welcome.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        autoRemove: false,
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
              child: BaseViewStateHandler(
                requestDataStatus: controller.status,
                onLoad: () => controller.onRetry(),
                child: CustomScrollView(
                  key: const PageStorageKey('home'),
                  slivers: [
                    BaseRefreshIndicator(onRefresh: () => controller.onRetry()),
                    const HomeWelcome(),
                    const HomeProfileSection(),
                    SliverToBoxAdapter(child: SizedBox(height: 14.h)),
                    const HomeTotalSaleCard(),
                    SliverToBoxAdapter(child: SizedBox(height: 18.h)),
                    const HomeTotalBuyBack(),
                    SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
