import '../../../utils/values/export.dart';

class BaseDropDownFilterMenu extends StatefulWidget {
  const BaseDropDownFilterMenu({
    Key? key,
    required this.onFilterMenuChagne,
    this.isWhite = false,
    required this.selectValue,
    this.listFilter,
  }) : super(key: key);

  final Function(String value) onFilterMenuChagne;
  final bool isWhite;
  final String? selectValue;
  final List<String>? listFilter;

  @override
  State<BaseDropDownFilterMenu> createState() => _BaseDropDownFilterMenuState();
}

class _BaseDropDownFilterMenuState extends State<BaseDropDownFilterMenu> {
  String _selectValue = "";
  List<String> _listFilter = [];
  @override
  void initState() {
    _listFilter = widget.listFilter ?? AppString.dateFilter;
    if (widget.selectValue == null) {
      if (widget.listFilter != null) {
        _selectValue = AppString.dateARFilter[0];
      } else {
        _selectValue = AppString.dateFilter[0];
      }
    } else {
      _selectValue = widget.selectValue!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      dropdownColor: const Color(0XFFF5F5F5),
      borderRadius: BorderRadius.circular(4.sp),
      focusColor: const Color(0XFFFDF0CC),
      hint: Padding(
        padding: EdgeInsets.only(top: 12.sp),
        child: Row(
          children: [
            Text(
              _selectValue.capitalize!,
              style: TextStyle(
                fontWeight: widget.isWhite ? FontWeight.w500 : FontWeight.w400,
                color: widget.isWhite ? AppColors.white : AppColors.softGray,
              ),
            ),
            SizedBox(width: 5.sp),
            SvgPicture.asset(
              AppIconPath.arrowDown,
              color: widget.isWhite ? AppColors.white : AppColors.softGray,
              width: 7.w,
              height: 7,
            )
          ],
        ),
      ),
      icon: const SizedBox(),
      underline: const SizedBox(),
      autofocus: true,
      alignment: Alignment.topCenter,
      items: _listFilter.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: _selectValue == value
              ? Text(
                  value.capitalize!,
                  style: const TextStyle(color: AppColors.primaryColor),
                )
              : Text(value.capitalize!),
        );
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          _selectValue = value!;
          widget.onFilterMenuChagne(value);
        });
      },
    );
  }
}
