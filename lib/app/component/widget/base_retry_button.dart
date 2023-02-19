import '../../../utils/values/export.dart';

class BaseRetryButton extends StatelessWidget {
  const BaseRetryButton({super.key, this.onTapRetry});
  final Function()? onTapRetry;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTapRetry,
          child: Container(
            height: 40.sp,
            width: 150.sp,
            padding: EdgeInsets.all(10.sp),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                width: .4,
                color: AppColors.dartGray,
              ),
            ),
            child: Text(
              'Click to try again',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.bigTitleColor, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
