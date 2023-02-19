import '../../../../utils/values/export.dart';
import 'state_component.dart';

class StateViewEmptyNotification extends StatelessWidget {
  const StateViewEmptyNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return StateComponent(
      stateIconPath: AppIconPath.emptyNotification,
      stateHeaderTitle: 'No Notifications',
      stateDesTitle:
          'Enable push notifications to let send you personal news and updates.',
      onTapRetry: () {},
    );
  }
}
