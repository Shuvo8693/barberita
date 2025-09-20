import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barberita/common/app_images/app_svg.dart';
import 'package:barberita/common/svg_base64/ExtractionBase64Image.dart';

class AppLogo extends StatelessWidget {
  final double? height;
  const AppLogo({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return ExtractBase64ImageWidget(svgAssetPath: AppSvg.barbaritaLogoSvg,height: height ?? 120.h);
  }
}
