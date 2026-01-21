import 'package:barberita/app/data/api_constants.dart';
import 'package:barberita/app/data/user_info.dart';
import 'package:barberita/app/modules/booking/model/feedback_response_model.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/app_images/network_image%20.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReviewHistoryCard extends StatelessWidget {
  final FeedbackData? feedbackData;

  const ReviewHistoryCard({super.key, this.feedbackData});

  @override
  Widget build(BuildContext context) {
    String? userRole = UserData().userRole;
    String? myId = UserData().myId;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  ===== Reviewer Info =============
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundImage: NetworkImage(
                  "${ApiConstants.baseUrl}${userRole?.contains('customer') == true ? feedbackData?.customerInfo?.image : feedbackData?.barberInfo?.image}",
                ),
                backgroundColor: Colors.grey[600],
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${userRole?.contains('customer') == true ? feedbackData?.customerInfo?.name : feedbackData?.barberInfo?.name}',
                      style: GoogleFontStyles.h5(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (feedbackData?.reviewInfo?.rating != null)
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16.sp),
                          SizedBox(width: 4.w),
                          Text(
                            feedbackData?.reviewInfo?.rating?.toStringAsFixed(
                                  1,
                                ) ??
                                '',
                            style: GoogleFontStyles.h6(
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),

              //======= Edit Button ==============
              if (feedbackData?.reviewInfo?.comment != null)
                GestureDetector(
                  onTap: () {
                    // Handle edit review
                    Get.toNamed(
                      Routes.FEEDBACK,
                      arguments: {
                        'barberId': feedbackData?.reviewInfo?.barberId,
                        'customerId': feedbackData?.reviewInfo?.customerId,
                        'myId': myId,
                        'bookingGroupId':feedbackData?.reviewInfo?.bookingGroupId,
                      },
                    );
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
                        Icon(Icons.edit, color: Colors.white, size: 14.sp),
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
            feedbackData?.reviewInfo?.comment ?? '',
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
              style: GoogleFontStyles.h6(color: Colors.white.withOpacity(0.5)),
            ),
          ),
        ],
      ),
    );
  }
}
