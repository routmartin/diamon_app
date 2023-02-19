import 'state_view/state_view.dart';
import 'state_view/state_view_loading.dart';
import '../../data/enums/enum_request_data_status.dart';
export '../../component/widget/base_refresh_indicator.dart';
import '../../../utils/values/export.dart';

class BaseViewStateHandler extends StatefulWidget {
  const BaseViewStateHandler(
      {super.key,
      required this.onLoad,
      required this.child,
      required this.requestDataStatus});

  final Function() onLoad;
  final RequestDataStatus requestDataStatus;
  final Widget child;

  @override
  State<BaseViewStateHandler> createState() => _BaseViewStateHandlerState();
}

class _BaseViewStateHandlerState extends State<BaseViewStateHandler> {
  _onRequestData() async {
    await widget.onLoad.call();
  }

  @override
  Widget build(BuildContext context) {
    return _buildStateViewSwticher();
  }

  Widget _buildStateViewSwticher() {
    Widget child;
    switch (widget.requestDataStatus) {
      case RequestDataStatus.failed:
        child = StateViewNoError(onTapRetry: _onRequestData);
        break;
      case RequestDataStatus.noResult:
        child = const StateViewNoResult();
        break;
      case RequestDataStatus.empty:
        child = const StateViewEmptyData();
        break;
      case RequestDataStatus.loading:
        child = const StateViewLoading();
        break;
      case RequestDataStatus.noNotification:
        child = const StateViewEmptyNotification();
        break;
      case RequestDataStatus.noInternet:
        child = StateViewNoInternet(onTapRetry: _onRequestData);
        break;
      case RequestDataStatus.completed:
        child = widget.child;
        break;
      default:
        child = const SizedBox();
    }
    return child;
  }
}
