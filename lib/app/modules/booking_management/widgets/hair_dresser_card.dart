import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/app/modules/booking_management/model/booking_management_models.dart';
import 'package:barberita/common/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class BarberCard extends StatelessWidget {
  final BookingData booking;

  const BarberCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: booking.imageUrl != null
                ? Image.asset(
                    booking.imageUrl!,
                    width: 60.w,
                    height: 60.h,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _placeholder(),
                  )
                : _placeholder(),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        booking.name,
                        style: GoogleFontStyles.h5(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    GestureDetector(
                      onTap: () {
                        // Handle tap action
                        Get.toNamed(Routes.REVIEW,arguments: {'userId':booking.userId});
                      },
                      child: buildRating(booking.rating),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  booking.service,
                  style: GoogleFontStyles.h6(
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: 8.h),
                _info('Address', booking.address),
                SizedBox(height: 4.h),
                _info('Phone Number', booking.phone),
                SizedBox(height: 4.h),
                _info('Today', booking.time),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildRating(String rating) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        children: [
          Icon(Icons.star, color: Colors.amber, size: 16.sp),
          horizontalSpacing(4.w),
          Text(rating, style: GoogleFontStyles.h6(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _placeholder() => Container(
    width: 60.w,
    height: 60.h,
    color: Colors.grey[600],
    child: Icon(Icons.person, color: Colors.white, size: 30.sp),
  );

  Widget _info(String label, String value) => Row(
    children: [
      Text(
        '$label:',
        style: GoogleFontStyles.h6(color: Colors.white.withOpacity(0.6)),
      ),
      SizedBox(width: 8.w),
      Expanded(
        child: Text(
          value,
          style: GoogleFontStyles.h6(color: Colors.white.withOpacity(0.9)),
        ),
      ),
    ],
  );
}
