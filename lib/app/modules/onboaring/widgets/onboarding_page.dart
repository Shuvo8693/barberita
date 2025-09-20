import 'package:barberita/app/modules/onboaring/views/onboaring_view.dart';
import 'package:barberita/common/app_color/app_colors.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
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
          Container(
            width: 300.w,
            height: 300.h,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(40.r),
            ),
            child: Center(
              child: Container(
                width: 250.w,
                height: 250.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.r),
                  child: Image.asset(
                    data.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Placeholder when image is not found
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.blue.shade100,
                              Colors.purple.shade100,
                              Colors.orange.shade100,
                            ],
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            _getPlaceholderIcon(data.title),
                            size: 80.sp,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 60.h),

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