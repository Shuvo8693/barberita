import 'package:barberita/app/data/api_constants.dart';
import 'package:barberita/app/modules/booking/controllers/booking_status_controller.dart';
import 'package:barberita/app/modules/booking/model/booking_status_model.dart';
import 'package:barberita/app/modules/hairdresser_details/controllers/booking_controller.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/jwt_decoder/payload_value.dart';
import 'package:flutter/cupertino.dart';
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

  final BookingStatusController _bookingStatusController = Get.put(BookingStatusController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((__)async{
     await role();
     await fetchBooking();
    });

  }

  String? _userRole;

  role()async{
    final payloadValue = await getPayloadValue();
    String role = payloadValue['userRole']??'';
    setState(() {
      _userRole = role;
    });
  }


  fetchBooking()async{
    _bookingStatusController.bookingsStatusModel.value.data?.clear();
    setState(() {});
    switch(widget.statusType){
      case BookingStatusType.active:
       await _bookingStatusController.fetchBookingStatus(bookingStatus:_userRole=='customer'? 'accepted-bookings':'barber-accepted-bookings');
        break;
      case BookingStatusType.request:
       await _bookingStatusController.fetchBookingStatus(bookingStatus: _userRole=='customer'? 'pending-bookings':'barber-pending-bookings' );
       break;
      case BookingStatusType.history:
       await _bookingStatusController.fetchBookingStatus(bookingStatus:_userRole=='customer'? 'completed-bookings':'barber-completed-bookings');
        break;
    }
  }
  // @override
  // void didChangeDependencies() async{
  //   super.didChangeDependencies();
  //
  // }

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
        Obx((){
          List<BookingStatusData> bookingStatusData = _bookingStatusController.bookingsStatusModel.value.data??[];
          if(_bookingStatusController.isLoadingBookingStatus.value){
            return Center(child: CupertinoActivityIndicator());
          } else if (bookingStatusData.isEmpty){
            return Center(child: Text('No booking status is available'));
          }
          return Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: bookingStatusData.length, // Sample count, can be replaced with dynamic data
              itemBuilder: (context, index) {
               final bookingStatusIndex = bookingStatusData[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: BookingCard(
                    name: bookingStatusIndex.userInfo?.name??'',
                    service: 'Hair Cut',
                    rating: '',
                    price: '\$${bookingStatusIndex.totalPrice?.toStringAsFixed(2)??''}',
                    time: bookingStatusIndex.time??'',
                    date: bookingStatusIndex.date??'',
                    role: _userRole ?? '',
                    status: _getStatus(widget.statusType),
                    imageUrl: '${ApiConstants.baseUrl}${bookingStatusIndex.userInfo?.image??''}',
                    onDetailsTap: () {
                      // Navigate to booking details
                      _getView(widget.statusType,bookingGroupId: bookingStatusIndex.bookingGroupId );
                    },
                  ),
                );
              },
            ),
          );
         }
        ),
      ],
    );
  }

  String _getListTitle(BookingStatusType statusType) {
    switch (statusType) {
      case BookingStatusType.active:
        if(_userRole=='customer'){
          return 'Your Active Booking';
        }else{
          return 'Your Active Order';
        }
      case BookingStatusType.request:
        if(_userRole=='customer'){
          return 'Your Pending Requests';
        }else{
          return 'Your Pending Order';
        }
      case BookingStatusType.history:
        if(_userRole=='customer'){
          return 'Booking History';
        }else{
          return 'Your Order History';
        }

    }
  }

   _getView(BookingStatusType statusType, {String? bookingGroupId}) {
    switch (statusType) {
      case BookingStatusType.active:
        return Get.toNamed(Routes.BOOKING_MANAGEMENT,arguments: {'bookingGroupId':bookingGroupId});
      case BookingStatusType.request:
        return Get.toNamed(Routes.BOOKING_MANAGEMENT,arguments: {'bookingGroupId':bookingGroupId});
      case BookingStatusType.history:
        return Get.toNamed(Routes.HISTORYDETAILS,arguments: {'bookingGroupId':bookingGroupId});
    }
  }

  String _getStatus(BookingStatusType statusType) {
    switch (statusType) {
      case BookingStatusType.active:
        if(_userRole=='customer'){
          return 'Confirmed';
        }else{
          return 'In-Progress';
        }
      case BookingStatusType.request:
        if(_userRole=='customer'){
          return 'Pending';
        }else{
          return 'Pending';
        }
      case BookingStatusType.history:
        return 'Completed';
    }
  }
}

