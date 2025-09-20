import 'package:barberita/app/modules/onboaring/views/onboaring_view.dart';
import 'package:barberita/common/app_color/app_colors.dart';
import 'package:barberita/common/app_images/app_images.dart';
import 'package:barberita/common/app_images/app_svg.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/svg_base64/ExtractionBase64Image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;

  const OnboardingPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration Container
          Expanded(child: Image.asset(data.imagePath,height: 200.h,)),

          SizedBox(height: 30.h),

          // Title
          Text(
            data.title,
            style: GoogleFontStyles.h1(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 32.sp,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 20.h),

          // Description
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              data.description,
              style: GoogleFontStyles.h5(
                color: Colors.white70,
                height: 1.5,
                fontSize: 16.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

IconData _getPlaceholderIcon(String title) {
  switch (title.toLowerCase()) {
    case 'appointment':
      return Icons.calendar_today;
    case 'explore':
      return Icons.explore;
    case 'enjoy':
      return Icons.favorite;
    default:
      return Icons.star;
  }
}