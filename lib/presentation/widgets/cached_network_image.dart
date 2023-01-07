import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/strings.dart';
import 'default_svg.dart';


// ignore: must_be_immutable
class DefaultCachedImage extends StatelessWidget {
  DefaultCachedImage(
      {Key? key, required this.backdropPath, this.width, this.height})
      : super(key: key);
  final String backdropPath;
  double? height;
  double? width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Visibility(
        visible: backdropPath != '',
        replacement: Padding(
          padding: EdgeInsets.all(14.sp),
          child: SizedBox(
            width: 90.w,
            height: 19.h,
            child:
            const DefaultSVG(imagePath: 'assets/icons/default_photo.svg'),
          ),
        ),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: imagesBaseURL + backdropPath,
          width: width,
          height: height,

          progressIndicatorBuilder: (context, url, downloadProgress) =>
              SizedBox(
                width: 85.w,
                height: 20.h,
                child: Center(
                  child:
                  CircularProgressIndicator(value: downloadProgress.progress),
                ),
              ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
