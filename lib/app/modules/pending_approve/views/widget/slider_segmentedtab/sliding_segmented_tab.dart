import '../../../../../../utils/values/export.dart';

class SlideingSegmentedTab extends StatelessWidget {
  const SlideingSegmentedTab({
    Key? key,
    required this.title,
    required this.isOnfocus,
  }) : super(key: key);
  final String title;
  final bool isOnfocus;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 6.sp),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: isOnfocus
            ? Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14.sp)
            : Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14.sp),
      ),
    );
  }
}
