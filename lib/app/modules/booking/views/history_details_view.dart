import 'package:barberita/app/modules/booking/widgets/review_history_card.dart';
import 'package:barberita/app/modules/booking_management/model/booking_management_models.dart';
import 'package:barberita/app/modules/booking_management/widgets/booking_status_card.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


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

              /// =================> Review Section <==================
              Text(
                'Review',
                style: GoogleFontStyles.h5(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 16.h),
              // Review Card
              ReviewHistoryCard(),
            ],
          ),
        ),
      ),
    );
  }
}


