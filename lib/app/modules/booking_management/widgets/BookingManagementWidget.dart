import 'package:barberita/app/data/user_info.dart';
import 'package:barberita/app/modules/booking/controllers/booking_status_controller.dart';
import 'package:barberita/app/modules/booking/controllers/feedback_controller.dart';
import 'package:barberita/app/modules/booking/widgets/review_history_card.dart';
import 'package:barberita/app/modules/booking_management/controllers/booking_management_controller.dart';
import 'package:barberita/app/modules/booking_management/model/booking_details_model.dart';
import 'package:barberita/app/modules/booking_management/widgets/order_rejection_dialouge.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:barberita/common/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:barberita/app/modules/booking_management/model/booking_management_models.dart';
import 'package:get/get.dart';

import 'booking_status_card.dart';
import 'hair_dresser_card.dart';
import 'order_details_card.dart';

class BookingManagementWidget extends StatefulWidget {
  final BookingData booking;
  final BookingDetailsData? bookingDetailsData;
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
    this.bookingDetailsData,
    this.isReviewHistoryPageActive = false,
    this.markAsDoneTap,
    this.isOrderCompleted = false,
    this.isLoadingMarkAsDone = false,
    this.isOrderInPending = false,
  });

  @override
  State<BookingManagementWidget> createState() => _BookingManagementWidgetState();
}

class _BookingManagementWidgetState extends State<BookingManagementWidget> {
  final FeedbackController  _feedbackController = Get.put(FeedbackController());
  @override
  void initState() {
    super.initState();
    getFeedback();
  }
  getFeedback()async{
    if(widget.isReviewHistoryPageActive){
      await _feedbackController.getFeedback();
    }

  }
  @override
  Widget build(BuildContext context) {
    String? userRole = UserData().userRole;
    String? myId = UserData().myId;
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
                      BarberCard(booking: widget.booking),
                      SizedBox(height: 24.h),
                      OrderDetailsCard(booking: widget.booking),
                      SizedBox(height: 24.h),
                      // if (userRole.isNotEmpty) ...[
                      //   userRole == 'customer'
                      //       ? BookingStatusCard(statuses: booking.statuses) // booking progress card
                      //       : isOrderInPending? _buildOrderConfirmation(context,orderId: booking.orderId) : SizedBox.shrink(),
                      // ],
                      /// ============ booking progress card and order confirmation ============
                      BookingStatusCard(statuses: widget.booking.statuses),
                      SizedBox(height: 25.h),
                      if (widget.userRole.isNotEmpty) ...[
                        widget.userRole != 'customer' && widget.isOrderInPending
                            ? _buildOrderConfirmation(context,
                                orderId: widget.booking.orderId) : SizedBox.shrink(),
                      ],
                      SizedBox(height: 12.h),
                      /// =================> Review Section <==================
                      if (widget.isReviewHistoryPageActive)
                        Obx((){
                        final feedbackData =  _feedbackController.feedbackResponseModel.value.data;
                        if(_feedbackController.isLoadingFeedback.value){
                          return const Center(child: CupertinoActivityIndicator());
                        }
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Review',
                                    style: GoogleFontStyles.h5(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Spacer(),
                                  TextButton(
                                    onPressed: () {
                                      Get.toNamed(
                                        Routes.FEEDBACK,
                                        arguments: {
                                          'barberId': widget.bookingDetailsData?.barberId,
                                          'customerId': widget.bookingDetailsData?.customerId,
                                          'myId': myId,
                                          'bookingGroupId':widget.bookingDetailsData?.orderId,
                                        },
                                      );
                                    },
                                    child: Text(
                                      'Add Review',
                                      style: GoogleFontStyles.h5(
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if(feedbackData!=null)
                              Wrap(
                                children: [
                                  SizedBox(height: 8.h),
                                  ReviewHistoryCard(feedbackData: feedbackData,),
                                ],
                              ),
                              SizedBox(height: 16.h),
                            ],
                          );
                         }

                        ),
                    ],
                  ),
                ),
              ),
            ),
            if (widget.userRole == 'customer' && !widget.isOrderCompleted)
              Container(
                padding: EdgeInsets.all(12.sp),
                child: CustomButton(
                  onTap: widget.markAsDoneTap ?? () {},
                  text: widget.isLoadingMarkAsDone ? 'Processing...' : 'Mark as Done',
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
              loading:
                  bookingManagementController.isLoadingConfirmation[0] ?? false,
              onTap: () async {
                await bookingManagementController.confirmOrDeclineOrder(
                  bookingGroupId: orderId,
                  status: 'accepted',
                  index: 0,
                );
              },
              text: 'Confirm',
            );
          }),
        ),
        SizedBox(width: 8.w),
        //=== confirm/decline ===
        Expanded(
          child: CustomButton(
            onTap: () {
              OrderRejectionDialog.show(
                context,
                onDecline: () async {
                  await bookingManagementController.confirmOrDeclineOrder(
                    bookingGroupId: orderId,
                    status: 'cancel',
                    index: 1,
                  );
                },
                onAccept: () async {
                  await bookingManagementController.confirmOrDeclineOrder(
                    bookingGroupId: orderId,
                    status: 'accepted',
                    index: 1,
                  );
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
