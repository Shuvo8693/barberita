import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
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

  const BookingManagementWidget({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Booking Management',),
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
                      BookingStatusCard(statuses: booking.statuses),
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              child: CustomButton(
                onTap: (){
                  Get.toNamed(Routes.FEEDBACK);
                },
                text: 'Done',
              ),
            ),
          ],
        ),
      ),
    );
  }
}


