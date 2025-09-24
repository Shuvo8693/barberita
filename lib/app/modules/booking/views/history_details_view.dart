import 'package:barberita/app/modules/booking_management/model/booking_management_models.dart';
import 'package:barberita/app/modules/booking_management/widgets/booking_status_card.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/app_images/network_image%20.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class HistoryDetailsView extends StatefulWidget {
  const HistoryDetailsView({super.key});

  @override
  State<HistoryDetailsView> createState() => _HistoryDetailsViewState();
}

class _HistoryDetailsViewState extends State<HistoryDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Booking History Details',),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 16.h),

              // Booking Status Section
              BookingStatusCard(
                statuses: [
                  BookingStatus(title: 'Booking Placed', timestamp: '20 Dec 2025, 11:20 PM', isCompleted: true),
                  BookingStatus(title: 'In progress', timestamp: '20 Dec 2025, 12:20 PM', isCompleted: true),
                  BookingStatus(title: 'Worked Done', timestamp: '20 Dec 2025, 1:20 PM', isCompleted: true),
                ],
              ),

              SizedBox(height: 32.h),

              // Review Section
              Text(
                'Review',
                style: GoogleFontStyles.h5(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 16.h),

              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2E),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Reviewer Info
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20.r,
                          backgroundImage:  NetworkImage(AppNetworkImage.saloonHairMen3Img),
                          backgroundColor: Colors.grey[600],
                        ),

                        SizedBox(width: 12.w),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'John Perkins',
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
                                    size: 16.sp,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    '4.5',
                                    style: GoogleFontStyles.h6(
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Edit Button
                        GestureDetector(
                          onTap: () {
                            // Handle edit review
                            Get.toNamed(Routes.FEEDBACK);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF55493E),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 14.sp,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  'Edit',
                                  style: GoogleFontStyles.h6(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // Review Text
                    Text(
                      'The barbers are highly skilled, offering everything from sharp, contemporary cuts to classic styles. The atmosphere is welcoming, with a nostalgic old-school vibe that makes it feel like you\'ve stepped into a time capsule of barbering excellence.....',
                      style: GoogleFontStyles.h6(
                        color: Colors.white.withOpacity(0.8),
                        height: 1.5,
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // Review Date
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '1 days ago',
                        style: GoogleFontStyles.h6(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
