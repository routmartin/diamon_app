// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';

import '../../../utils/values/export.dart';

class BaseCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final bool? isNeedBacground;
  final double? padding;
  final BoxFit? boxFit;
  const BaseCachedNetworkImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.isNeedBacground = false,
    this.padding = 28,
    this.boxFit = BoxFit.cover,
  }) : super(key: key);

  _checkMemory() {
    ImageCache imageCache = PaintingBinding.instance.imageCache;
    if (imageCache.liveImageCount >= 120) {
      imageCache.clear();
      imageCache.clearLiveImages();
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkMemory();
    return CachedNetworkImage(
      cacheKey: imageUrl,
      imageUrl: imageUrl,
      fit: boxFit,
      width: width,
      height: height,
      maxHeightDiskCache: 500,
      maxWidthDiskCache: 500,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: boxFit),
        ),
      ),
      errorWidget: (context, url, error) => Center(
        child: Icon(
          Icons.account_circle,
          size: 16.sp,
        ),
      ),
    );
  }
}
