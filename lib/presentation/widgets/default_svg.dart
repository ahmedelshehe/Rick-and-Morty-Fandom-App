import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DefaultSVG extends StatelessWidget {
  final double? height;
  final double? width;
  final String imagePath;
  final BoxFit fit;
  final Color? color;
  final AlignmentGeometry alignment;

  const DefaultSVG({
    Key? key,
    this.height,
    this.width,
    required this.imagePath,
    this.fit = BoxFit.contain,
    this.color,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      imagePath,
      width: width,
      height: height,
      alignment: alignment,
      fit: fit,
      color: color,
    );
  }
}