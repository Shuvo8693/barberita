import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/prefs_helper/prefs_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'booking_card.dart';

enum BookingStatusType { active, request, history }

class BookingList extends StatefulWidget {
  final BookingStatusType statusType;

  const BookingList({super.key, required this.statusType});

  @override
  State<BookingList> createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {


  @override
  void initState() {
    super.initState();
    role();
  }

  String? _userRole;
  role()async{
    final role = await PrefsHelper.getString('role');
    setState(() {
      _userRole = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            _getListTitle(widget.statusType),
            style: GoogleFontStyles.h5(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: 4, // Sample count, can be replaced with dynamic data
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: BookingCard(
                  name: 'Darlene Robertson',
                  service: 'Hair Cut',
                  rating: '4.5',
                  price: '\$ 17.84',
                  time: '4:00 PM - 5:00 PM',
                  date: '12.12.25',
                  role: _userRole??'',
                  status: _getStatus(widget.statusType),
                  imageUrl: 'assets/images/hairdresser${index + 1}.jpg',
                  onDetailsTap: () {
                    // Navigate to booking details
                    _getView(widget.statusType);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _getListTitle(BookingStatusType statusType) {
    switch (statusType) {
      case BookingStatusType.active:
        if(_userRole=='User'){
          return 'Your Active Booking';
        }else{
          return 'Your Active Order';
        }
      case BookingStatusType.request:
        if(_userRole=='User'){
          return 'Your Pending Requests';
        }else{
          return 'Your Pending Order';
        }
      case BookingStatusType.history:
        if(_userRole=='User'){
          return 'Booking History';
        }else{
          return 'Your Order History';
        }

    }
  }

   _getView(BookingStatusType statusType) {
    switch (statusType) {
      case BookingStatusType.active:
        return Get.toNamed(Routes.BOOKING_MANAGEMENT);
      case BookingStatusType.request:
        return Get.toNamed(Routes.BOOKING_MANAGEMENT);
      case BookingStatusType.history:
        return Get.toNamed(Routes.HISTORYDETAILS);
    }
  }

  String _getStatus(BookingStatusType statusType) {
    switch (statusType) {
      case BookingStatusType.active:
        if(_userRole=='User'){
          return 'Confirmed';
        }else{
          return 'In-Progress';
        }
      case BookingStatusType.request:
        if(_userRole=='User'){
          return 'Pending';
        }else{
          return 'Pending';
        }
      case BookingStatusType.history:
        return 'Completed';
    }
  }
}

