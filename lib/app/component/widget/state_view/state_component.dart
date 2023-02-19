import '../../../../utils/values/export.dart';
import '../base_retry_button.dart';
export '../../../../utils/values/app_icon_path.dart';

class StateComponent extends StatelessWidget {
  final String stateIconPath;
  final String stateHeaderTitle;
  final String stateDesTitle;
  final bool isNeedRetry;
  final Function()? onTapRetry;

  const StateComponent({
    super.key,
    required this.stateIconPath,
    required this.stateHeaderTitle,
    required this.stateDesTitle,
    required this.onTapRetry,
    this.isNeedRetry = false,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              stateIconPath,
              width: 200.sp,
              height: 200.sp,
            ),
            SizedBox(height: 40.sp),
            Text(
              stateHeaderTitle,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 15.sp),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: Text(
                stateDesTitle,
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10.sp),
            isNeedRetry
                ? BaseRetryButton(onTapRetry: onTapRetry)
                : const SizedBox(),
            isNeedRetry ? SizedBox(height: 10.sp) : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
