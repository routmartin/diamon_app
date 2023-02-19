import '../../../controllers/history_controller.dart';
import '../../../../../../utils/values/export.dart';

class HistorySearchBox extends GetView<HistoryController> {
  const HistorySearchBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Appsize.cardPadding),
      padding: EdgeInsets.symmetric(
        horizontal: Appsize.primaryPadding,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Appsize.primaryBorderRadius),
        color: AppColors.white,
        boxShadow: AppDecoration.primaryCardShadow,
      ),
      child: StatefulBuilder(
        builder: (context, setState) => Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.sp),
              child: SvgPicture.asset(
                AppIconPath.search,
                width: 18.sp,
                height: 18.sp,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: TextFormField(
                showCursor: true,
                textInputAction: TextInputAction.search,
                controller: controller.txtSearcher,
                onEditingComplete: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  controller.onSearch();
                },
                onChanged: (value) {
                  setState.call(() {});
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(2),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: 'Search By Customer',
                  hintStyle: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
            if (controller.txtSearcher.text.isNotEmpty)
              GestureDetector(
                onTap: () {
                  controller.onserchClear();
                  setState.call(() {});
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.sp),
                  child: const Icon(Icons.close),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
