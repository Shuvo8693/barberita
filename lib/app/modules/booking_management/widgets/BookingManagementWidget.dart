import 'package:barberita/app/modules/booking/widgets/review_history_card.dart';
import 'package:barberita/app/modules/booking_management/controllers/booking_management_controller.dart';
import 'package:barberita/app/modules/booking_management/widgets/order_rejection_dialouge.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:barberita/common/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:barberita/app/modules/booking_management/model/booking_management_models.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'booking_status_card.dart';
import 'hair_dresser_card.dart';
import 'order_details_card.dart';

class BookingManagementWidget extends StatelessWidget {
  final BookingData booking;
  final String userRole;
  final bool isReviewHistoryPageActive;
  final bool isOrderCompleted;
  final bool isOrderInPending;
  final bool isLoadingMarkAsDone;
  final VoidCallback? markAsDoneTap;

  const BookingManagementWidget({
    super.key,
    required this.booking,
    required this.userRole,
    this.isReviewHistoryPageActive = false,
    this.markAsDoneTap,
    this.isOrderCompleted = false,
    this.isLoadingMarkAsDone = false,
     this.isOrderInPending = false,
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
                      //==== barber card =====
                      BarberCard(booking: booking),
                      SizedBox(height: 24.h),
                      OrderDetailsCard(booking: booking),
                      SizedBox(height: 24.h),
                      if (userRole.isNotEmpty) ...[
                        userRole == 'customer'
                            ? BookingStatusCard(statuses: booking.statuses) // booking progress card
                            : isOrderInPending? _buildOrderConfirmation(context,orderId: booking.orderId) : SizedBox.shrink(),
                      ],
                      SizedBox(height: 32.h),

                      /// =================> Review Section <==================

                      if (isReviewHistoryPageActive)
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
                  onTap: markAsDoneTap ?? () {},
                  text: isLoadingMarkAsDone ? 'Processing...' : 'Mark as Done',
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderConfirmation(BuildContext context, {String? orderId}) {
     final bookingManagementController = Get.put(BookingManagementController());
    return Row(
      children: [
        //=== confirm ===
        Expanded(
          child: Obx(() {
            return CustomButton(
              loading: bookingManagementController.isLoadingConfirmation[0]??false,
                onTap: () async {
                  await bookingManagementController.confirmOrDeclineOrder(
                      bookingGroupId: orderId, status: 'accepted',index: 0);
                },
                text: 'Confirm'
            );
          }
          ),
        ),
        SizedBox(width: 8.w),
        //=== confirm/decline ===
        Expanded(
          child: CustomButton(
            onTap: () {
              OrderRejectionDialog.show(
                context,
                onDecline: ()async {
                  await bookingManagementController.confirmOrDeclineOrder( bookingGroupId: orderId , status: 'cancel',index: 1);
                },
                onAccept: () async {
                  await bookingManagementController.confirmOrDeclineOrder(bookingGroupId: orderId,status: 'accepted',index: 1);
                },
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
