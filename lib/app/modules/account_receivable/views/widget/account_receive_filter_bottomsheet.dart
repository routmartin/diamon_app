import '../../../../../utils/values/export.dart';
import '../../../../component/widget/base_action_button.dart';

class AccountReceiveFilterBottomSheet extends StatefulWidget {
  const AccountReceiveFilterBottomSheet(
      {Key? key,
      required this.onApplyFilter,
      required this.filterByReqeustGroup})
      : super(key: key);
  final Function(String? type) onApplyFilter;
  final String? filterByReqeustGroup;
  @override
  State<AccountReceiveFilterBottomSheet> createState() =>
      _AccountReceiveFilterBottomSheetState();
}

class _AccountReceiveFilterBottomSheetState
    extends State<AccountReceiveFilterBottomSheet> {
  @override
  void initState() {
    if (widget.filterByReqeustGroup != null) {
      _filterByReqeustGroup = widget.filterByReqeustGroup!;
    }
    super.initState();
  }

  String? _filterByReqeustGroup = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(16.sp),
          right: Radius.circular(16.sp),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Type',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontSize: 16.sp),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.dartGray,
                  ),
                )
              ],
            ),
            SizedBox(height: 12.sp),
            ...List.generate(
              AppString.arFilter.length,
              (index) => ListTile(
                onTap: () => _onFilterType(AppString.arFilter[index]),
                contentPadding: const EdgeInsets.all(0),
                title: Text(
                  AppString.arFilter[index],
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                trailing: Radio<String>(
                  value: AppString.arFilter[index].capitalize!,
                  groupValue: _filterByReqeustGroup,
                  toggleable: true,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  fillColor: MaterialStateColor.resolveWith(
                    (states) => AppColors.primaryColor,
                  ),
                  onChanged: (String? value) {
                    _onFilterType(value);
                  },
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                BaseActionButton(
                    label: 'Close', isBorder: true, onAction: Get.back),
                SizedBox(width: 8.w),
                BaseActionButton(
                    label: 'Apply', isBorder: false, onAction: _onFilterApply)
              ],
            )
          ],
        ),
      ),
    );
  }

  _onFilterApply() {
    if (_filterByReqeustGroup == '') {
      return BaseToast.showErorrBaseToast('Please select filter');
    }
    widget.onApplyFilter(_filterByReqeustGroup);
    Get.back();
  }

  _onFilterType(String? value) {
    _filterByReqeustGroup = value?.capitalize;
    setState(() {});
  }
}
