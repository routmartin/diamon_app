import '../../../../../utils/values/export.dart';
import '../../../../component/widget/base_action_button.dart';

class PendingApprovalFilterBottomsheet extends StatefulWidget {
  const PendingApprovalFilterBottomsheet(
      {Key? key,
      required this.onApplyFilter,
      this.selectedDate,
      this.selectedType})
      : super(key: key);
  final String? selectedDate;
  final String? selectedType;
  final Function(String? date, String? type) onApplyFilter;
  @override
  State<PendingApprovalFilterBottomsheet> createState() =>
      _PendingApprovalFilterBottomsheetState();
}

class _PendingApprovalFilterBottomsheetState
    extends State<PendingApprovalFilterBottomsheet> {
  String? _filterByDate;
  String? _filterByReqeustGroup;

  @override
  void initState() {
    if (widget.selectedDate != null) {
      _filterByDate = widget.selectedDate?.capitalize;
    }
    if (widget.selectedType != null) {
      _filterByReqeustGroup = widget.selectedType?.capitalize;
    }
    super.initState();
  }

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
                  'Date',
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
              AppString.dateFilter.length,
              (index) => ListTile(
                onTap: () {
                  _onFilterDate(AppString.dateFilter[index].capitalize!);
                },
                contentPadding: const EdgeInsets.all(0),
                title: Text(
                  AppString.dateFilter[index].capitalize!,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                trailing: Radio<String>(
                  value: AppString.dateFilter[index].capitalize!,
                  groupValue: _filterByDate,
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  toggleable: true,
                  fillColor: MaterialStateColor.resolveWith(
                    (states) => AppColors.primaryColor,
                  ),
                  onChanged: (String? value) {
                    _onFilterDate(value);
                  },
                ),
              ),
            ),
            SizedBox(height: 12.sp),
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
              ],
            ),
            SizedBox(height: 12.sp),
            ...List.generate(
              AppString.requestApprovalType.length,
              (index) => ListTile(
                onTap: () =>
                    _onFilterByGroup(AppString.requestApprovalType[index]),
                contentPadding: const EdgeInsets.all(0),
                title: Text(
                  AppString.requestApprovalType[index],
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                trailing: Radio<String>(
                  value: AppString.requestApprovalType[index].capitalize!,
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
                    _onFilterByGroup(value);
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
    widget.onApplyFilter(_filterByDate, _filterByReqeustGroup);
    Get.back();
  }

  _onFilterDate(String? date) {
    _filterByDate = date?.capitalize;
    setState(() {});
  }

  _onFilterByGroup(String? group) {
    _filterByReqeustGroup = group?.capitalize;
    setState(() {});
  }
}
