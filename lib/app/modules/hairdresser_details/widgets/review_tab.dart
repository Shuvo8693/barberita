import 'package:barberita/common/app_images/network_image%20.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/widgets/casess_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Reviews Tab Widget
class ReviewsTab extends StatelessWidget {
  const ReviewsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Review Header
          Text(
            'Review (1208)',
            style: GoogleFontStyles.h4(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20.h),

          // Review Items
          _buildReviewItem(
            'John Perkins',
            '4.5',
            '1 days ago',
            'The barbers are highly skilled, offering everything from sharp, contemporary cuts to classic styles. The atmosphere is welcoming, with a nostalgic old-school vibe that makes it feel like you\'ve stepped into a time capsule of barbering excellence.',
            AppNetworkImage.saloonHairMen3Img,
          ),
          SizedBox(height: 20.h),

          _buildReviewItem(
            'John Perkins',
            '4.2',
            '1 days ago',
            'The barbers are highly skilled, offering everything from sharp, contemporary cuts to classic styles. The atmosphere is welcoming, with a nostalgic old-school vibe that makes it feel like you\'ve stepped into a time capsule of barbering excellence.',
            AppNetworkImage.saloonHairMen4Img,
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(String name, String rating, String time, String review, String imageUrl) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info
          Row(
            children: [
              CustomNetworkImage(
                imageUrl: imageUrl,
                width: 40.w,
                height: 40.h,
                boxFit: BoxFit.cover,
                borderRadius: BorderRadius.all(Radius.circular(24.r)),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFontStyles.h5(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 14.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          rating,
                          style: GoogleFontStyles.h6(
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                time,
                style: GoogleFontStyles.h6(
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Review Text
          Text(
            review,
            style: GoogleFontStyles.h6(
              color: Colors.white.withOpacity(0.8),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

