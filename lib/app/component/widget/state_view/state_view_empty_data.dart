import '../../../../utils/values/export.dart';
import 'state_component.dart';

class StateViewEmptyData extends StatelessWidget {
  const StateViewEmptyData({super.key});

  @override
  Widget build(BuildContext context) {
    return StateComponent(
      stateIconPath: AppIconPath.noResult,
      stateHeaderTitle: 'No Data',
      stateDesTitle: 'Sorry, there are no data',
      onTapRetry: null,
    );
  }
}
