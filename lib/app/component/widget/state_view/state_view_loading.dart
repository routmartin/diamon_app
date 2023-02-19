import '../../../../utils/values/export.dart';
import '../loading/base_loading.dart';

class StateViewLoading extends StatelessWidget {
  const StateViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: AppColors.scaffoldBackground,
      child: const BaseLoading(),
    );
  }
}
