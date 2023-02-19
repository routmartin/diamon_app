import '../../../../utils/values/export.dart';
import 'state_component.dart';

class StateViewNoInternet extends StatelessWidget {
  final Function() onTapRetry;
  const StateViewNoInternet({super.key, required this.onTapRetry});

  @override
  Widget build(BuildContext context) {
    return StateComponent(
      stateIconPath: AppIconPath.noInternet,
      stateHeaderTitle: 'No Internet',
      stateDesTitle:
          'No Internet connection found. Check your connection or try again.',
      isNeedRetry: true,
      onTapRetry: onTapRetry,
    );
  }
}
