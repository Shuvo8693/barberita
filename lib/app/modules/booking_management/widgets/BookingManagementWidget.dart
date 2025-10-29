import 'package:barberita/app/modules/booking/widgets/review_history_card.dart';
import 'package:barberita/app/modules/booking_management/widgets/order_rejection_dialouge.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:barberita/common/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:barberita/app/modules/booking_management/model/booking_management_models.dart';

import 'booking_status_card.dart';
import 'hair_dresser_card.dart';
import 'order_details_card.dart';

class BookingManagementWidget extends StatelessWidget {
  final BookingData booking;
  final String userRole;
  final bool isReviewHistoryPageActive;
  final bool isOrderCompleted;
  final VoidCallback? markAsDoneTap;

  const BookingManagementWidget({
    super.key,
    required this.booking,
    required this.userRole, this.isReviewHistoryPageActive = false, this.markAsDoneTap,  this.isOrderCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Booking Management'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HairdresserCard(booking: booking),
                      SizedBox(height: 24.h),
                      OrderDetailsCard(booking: booking),
                      SizedBox(height: 24.h),
                      if (userRole.isNotEmpty) ...[
                        userRole == 'customer'
                            ? BookingStatusCard(statuses: booking.statuses)
                            : _buildOrderConfirmation(context),
                      ],
                      SizedBox(height: 32.h),

                      /// =================> Review Section <==================
                      if(isReviewHistoryPageActive)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Review',
                            style: GoogleFontStyles.h5(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          ReviewHistoryCard(),
                          SizedBox(height: 16.h),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (userRole == 'customer' && !isOrderCompleted)
              Container(
                padding: EdgeInsets.all(12.sp),
                child: CustomButton(
                  onTap: markAsDoneTap??(){},
                  text: 'Mark as Done',
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderConfirmation(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(onTap: () {}, text: 'Confirm'),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: CustomButton(
            onTap: () {
              OrderRejectionDialog.show(
                context,
                onDecline: () {},
                onAccept: () {},
              );
            },
            text: 'Decline',
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
