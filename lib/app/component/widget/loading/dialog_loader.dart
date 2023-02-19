import '../../../../utils/values/app_color.dart';
import 'package:flutter/material.dart';

enum LoaderTheme { dialogDefault, dialogCircle }

class DialogLoader {
  final ValueNotifier<Widget> _title = ValueNotifier<Widget>(const SizedBox());
  final ValueNotifier<Widget> _leftIcon =
      ValueNotifier<Widget>(const SizedBox());
  final ValueNotifier<Widget> _rightIcon =
      ValueNotifier<Widget>(const SizedBox());
  final ValueNotifier<bool> _barrierDismissible = ValueNotifier<bool>(false);
  final ValueNotifier<double> _avatarRadius = ValueNotifier<double>(25.0);

  bool _dialogIsOpen = false;
  late BuildContext _context;

  DialogLoader({required context}) {
    _context = context;
  }

  void update({
    Widget? title,
    Widget? leftIcon,
    Widget? rightIcon,
    bool barrierDismissible = false,
    bool autoClose = true,
    double? avatarRadius,
  }) {
    _title.value = title ?? const SizedBox();
    _leftIcon.value = leftIcon ?? const SizedBox();
    _rightIcon.value = rightIcon ?? const SizedBox();
    _avatarRadius.value = avatarRadius ?? 25.0;
    _barrierDismissible.value = barrierDismissible;
    if (autoClose) _closeAfterUpdate();
  }

  void _closeAfterUpdate() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (_dialogIsOpen) {
        Navigator.pop(_context);
        _dialogIsOpen = false;
      }
    });
  }

  void close() {
    if (_dialogIsOpen) {
      Navigator.pop(_context);
      _dialogIsOpen = false;
    }
  }

  show({
    LoaderTheme theme = LoaderTheme.dialogDefault,
    Widget title = const SizedBox(),
    Widget leftIcon = const SizedBox(),
    Widget rightIcon = const SizedBox(),
    Color backgroundColor = Colors.white,
    Color barrierColor = Colors.black26,
    bool barrierDismissible = false,
    double elevation = 5.0,
    double borderRadius = 5.0,
    double avatarRadius = 25.0,
  }) {
    _dialogIsOpen = true;
    _title.value = title;
    _barrierDismissible.value = barrierDismissible;
    _rightIcon.value = rightIcon;
    _leftIcon.value = leftIcon;
    _avatarRadius.value = avatarRadius;

    return showGeneralDialog(
      context: _context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Wrap(
          children: [
            AnimatedBuilder(
              animation: Listenable.merge(
                [
                  _title,
                  _leftIcon,
                  _rightIcon,
                  _barrierDismissible,
                  _avatarRadius,
                ],
              ),
              builder: (BuildContext context, _) {
                return GestureDetector(
                  onTap: () => _barrierDismissible.value ? close() : null,
                  child: CircleTheme(
                    context: _context,
                    leftIcon: _leftIcon,
                    title: _title,
                    avatarRadius: _avatarRadius,
                    rightIcon: _rightIcon,
                    barrierColor: barrierColor,
                    elevation: elevation,
                    borderRadius: borderRadius,
                    backgroundColor: backgroundColor,
                  ),
                );
              },
            ),
          ],
        );
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(_context).modalBarrierDismissLabel,
      barrierColor: barrierColor,
      transitionDuration: const Duration(milliseconds: 200),
    );
  }
}

class CircleTheme extends StatelessWidget {
  const CircleTheme({
    Key? key,
    required BuildContext context,
    required ValueNotifier<Widget> leftIcon,
    required ValueNotifier<Widget> title,
    required ValueNotifier<Widget> rightIcon,
    required ValueNotifier<double> avatarRadius,
    required Color backgroundColor,
    required Color barrierColor,
    required double elevation,
    required double borderRadius,
  })  : _context = context,
        _title = title,
        _backgroundColor = backgroundColor,
        _barrierColor = barrierColor,
        _elevation = elevation,
        _borderRadius = borderRadius,
        _avatarRadius = avatarRadius,
        super(key: key);

  final BuildContext _context;
  final ValueNotifier<Widget> _title;
  final ValueNotifier<double> _avatarRadius;

  final Color _backgroundColor;
  final Color _barrierColor;
  final double _elevation;
  final double _borderRadius;

  static const double padding = 20;
  static const double toppadding = 30;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(_context).size.width,
      height: MediaQuery.of(_context).size.height,
      color: _barrierColor,
      child: Center(
        child: Material(
          type: MaterialType.transparency,
          elevation: _elevation,
          child: Stack(
            children: [
              Container(
                constraints: BoxConstraints(
                  maxHeight: 80.sp,
                  maxWidth: 80.sp,
                ),
                padding: const EdgeInsets.only(
                  left: padding,
                  top: padding,
                  right: padding,
                  bottom: padding,
                ),
                margin: EdgeInsets.only(top: _avatarRadius.value),
                decoration: BoxDecoration(
                  color: _backgroundColor,
                  borderRadius: BorderRadius.circular(_borderRadius),
                ),
                child: Center(child: _title.value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
