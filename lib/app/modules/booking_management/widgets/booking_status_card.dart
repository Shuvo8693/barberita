import 'package:barberita/app/modules/booking_management/model/booking_management_models.dart';
import 'package:barberita/common/app_color/app_colors.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingStatusCard extends StatelessWidget {

  final List<BookingStatus> statuses;
  const BookingStatusCard({super.key, required this.statuses});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Booking Status', style: GoogleFontStyles.h5(color: Colors.white, fontWeight: FontWeight.w600)),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(color: const Color(0xFF2C2C2E), borderRadius: BorderRadius.circular(12.r)),
          child: Column(children: [
            for (int i = 0; i < statuses.length; i++)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status container
                  Column(children: [
                    Container(
                      width: 24.w, height: 24.h,
                      decoration: BoxDecoration(
                        color: statuses[i].isCompleted ? const Color(0xFF55493E) : Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(color: statuses[i].isCompleted ? const Color(0xFF55493E) : AppColors.secondaryAppColor, width: 2),
                      ),
                      child: statuses[i].isCompleted ? Icon(Icons.check, color: Colors.white, size: 14.sp) : null,
                    ),
                    if (i != statuses.length -1) Container(width: 2.w, height: 40.h, color: AppColors.secondaryAppColor),
                  ]),
                  SizedBox(width: 16.w),
                  // Status text
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(statuses[i].title, style: GoogleFontStyles.h5(color: Colors.white, fontWeight: FontWeight.w500)),
                          SizedBox(height: 4.h),
                          Text(statuses[i].timestamp, style: GoogleFontStyles.h6(color: Colors.white.withOpacity(0.6))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          ]),
        ),
      ],
    );
  }
}