import 'dart:io';
import 'dart:math';

import '../../../utils/values/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/values/app_size.dart';

Widget buildAppleRefreshIndicator(
  BuildContext context,
  RefreshIndicatorMode refreshState,
  double pulledExtent,
  double refreshTriggerPullDistance,
  double refreshIndicatorExtent,
) {
  const Curve opacityCurve = Interval(0.4, 0.8, curve: Curves.easeInOut);
  return Align(
    alignment: Alignment.bottomCenter,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: refreshState == RefreshIndicatorMode.drag
          ? Opacity(
              opacity: opacityCurve.transform(
                  min(pulledExtent / refreshTriggerPullDistance, .8)),
              child: const Icon(
                CupertinoIcons.down_arrow,
                color: CupertinoColors.inactiveGray,
                size: 36.0,
              ),
            )
          : Opacity(
              opacity: opacityCurve
                  .transform(min(pulledExtent / refreshIndicatorExtent, .8)),
              child: const CupertinoActivityIndicator(radius: 14.0),
            ),
    ),
  );
}

Widget buildAndroidRefreshIndicator(
  BuildContext context,
  RefreshIndicatorMode refreshState,
  double pulledExtent,
  double refreshTriggerPullDistance,
  double refreshIndicatorExtent,
) {
  const Curve opacityCurve = Interval(0.4, 0.8, curve: Curves.easeInOut);
  return Align(
    alignment: Alignment.bottomCenter,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: refreshState == RefreshIndicatorMode.drag
          ? Opacity(
              opacity: opacityCurve.transform(
                  min(pulledExtent / refreshTriggerPullDistance, 1.0)),
              child: const Icon(
                Icons.arrow_downward,
                // color: CupertinoColors.inactiveGray,
                color: AppColors.primaryColor,
                size: 24.0,
              ),
            )
          : Opacity(
              opacity: opacityCurve
                  .transform(min(pulledExtent / refreshIndicatorExtent, 1.0)),
              child: const CircularProgressIndicator(
                strokeWidth: 1.5,
                valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
              ),
            ),
    ),
  );
}

class BaseRefreshIndicator extends StatelessWidget {
  final Function() onRefresh;
  const BaseRefreshIndicator({Key? key, required this.onRefresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(top: Appsize.primaryPadding),
      sliver: CupertinoSliverRefreshControl(
        onRefresh: () => onRefresh.call(),
        builder: Platform.isIOS
            ? buildAppleRefreshIndicator
            : buildAndroidRefreshIndicator,
      ),
    );
  }
}
