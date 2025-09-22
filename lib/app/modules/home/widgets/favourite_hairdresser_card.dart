import 'package:barberita/common/app_color/app_colors.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/widgets/casess_network_image.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouriteHairdresserCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String type;
  final String status;
  final String rating;
  final String price;
  final VoidCallback onTap;

  const FavouriteHairdresserCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.type,
    required this.status,
    required this.rating,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          CustomNetworkImage(
            width: 80.w,
            height: 80.h,
            boxFit: BoxFit.cover,
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            imageUrl: imageUrl,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: GoogleFontStyles.h5(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(Icons.favorite, color: Colors.red, size: 20.sp),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  type,
                  style: GoogleFontStyles.h6(color: const Color(0xFFE6C4A3)),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text(
                      status,
                      style: GoogleFontStyles.h6(color: Colors.green),
                    ),
                    SizedBox(width: 8.w),
                    Icon(Icons.star, color: Colors.amber, size: 14.sp),
                    SizedBox(width: 2.w),
                    Text(
                      rating,
                      style: GoogleFontStyles.h6(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Text(
                      'Price Range: $price',
                      style: GoogleFontStyles.h6(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    const Spacer(),
                    CustomButton(
                      onTap: onTap,
                      text: 'Book now',
                      height: 25.h,
                      width: 70.w,
                      textStyle: GoogleFontStyles.h6(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
