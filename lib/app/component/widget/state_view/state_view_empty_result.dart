import '../../../../utils/values/export.dart';
import 'state_component.dart';

class StateViewNoResult extends StatelessWidget {
  const StateViewNoResult({super.key});

  @override
  Widget build(BuildContext context) {
    return StateComponent(
      stateIconPath: AppIconPath.noResult,
      stateHeaderTitle: 'No Results',
      stateDesTitle:
          'Sorry, there are no results for this search. Please try another phrase',
      onTapRetry: null,
    );
  }
}
