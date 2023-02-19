import '../../../../utils/values/export.dart';
import 'state_component.dart';

class StateViewNoError extends StatelessWidget {
  final Function() onTapRetry;
  const StateViewNoError({super.key, required this.onTapRetry});

  @override
  Widget build(BuildContext context) {
    return StateComponent(
      stateIconPath: AppIconPath.error,
      stateHeaderTitle: 'Error',
      stateDesTitle: 'Somethings when wrong',
      onTapRetry: onTapRetry,
      isNeedRetry: true,
    );
  }
}
