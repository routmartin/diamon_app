import 'dart:io';
import 'package:flutter/cupertino.dart';
import '../base_retry_button.dart';
import '../../../../utils/values/export.dart';

class BaseLoadMore extends StatelessWidget {
  final LoadMoreStatus? loadMoreStatus;
  final Function() onLoadMore;
  const BaseLoadMore(
      {super.key, this.loadMoreStatus, required this.onLoadMore});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Padding(
      padding: EdgeInsets.only(bottom: 20.sp),
      child: _buildLoadMoreStateViewHandler(context),
    ));
  }

  _buildLoadMoreStateViewHandler(context) {
    switch (loadMoreStatus) {
      case LoadMoreStatus.loading:
        return Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Platform.isAndroid
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                  )
                : CupertinoActivityIndicator(radius: 12.0.sp),
            SizedBox(width: 10.sp),
            Text(
              'Loading...',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        );
      case LoadMoreStatus.noConnection:
        return SizedBox(
          child: Column(
            children: [
              Text(
                'No Internet',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 6.sp),
              BaseRetryButton(onTapRetry: onLoadMore),
            ],
          ),
        );
      case LoadMoreStatus.fullLoaded:
        return SizedBox(
          child: Text(
            'No More Data',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        );
      case LoadMoreStatus.noPaginate:
        return const SizedBox();
      case LoadMoreStatus.errorRequest:
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Something wrong',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 6.sp),
            BaseRetryButton(onTapRetry: onLoadMore),
          ],
        );
    }
  }
}

enum LoadMoreStatus {
  errorRequest,
  noConnection,
  loading,
  noPaginate,
  fullLoaded,
}
