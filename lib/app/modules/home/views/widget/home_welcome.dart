import '../../../../../utils/values/export.dart';

class HomeWelcome extends StatelessWidget {
  const HomeWelcome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Appsize.cardPadding),
        child: Text(
          'Welcome,',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: 16.sp,
              ),
        ),
      ),
    );
  }
}
