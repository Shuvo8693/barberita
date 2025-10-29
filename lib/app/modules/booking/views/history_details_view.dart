import 'package:barberita/app/modules/booking/controllers/booking_status_controller.dart';
import 'package:barberita/app/modules/booking/widgets/review_history_card.dart';
import 'package:barberita/app/modules/booking_management/controllers/booking_management_controller.dart';
import 'package:barberita/app/modules/booking_management/model/booking_details_model.dart';
import 'package:barberita/app/modules/booking_management/model/booking_management_models.dart';
import 'package:barberita/app/modules/booking_management/widgets/BookingManagementWidget.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/jwt_decoder/payload_value.dart';
import 'package:barberita/common/widgets/custom_page_loading.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HistoryDetailsView extends StatefulWidget {
  const HistoryDetailsView({super.key});

  @override
  State<HistoryDetailsView> createState() => _HistoryDetailsViewState();
}

class _HistoryDetailsViewState extends State<HistoryDetailsView> {
  final BookingStatusController _bookingStatusController = Get.put(BookingStatusController());

  String _userRole = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    try {
      final payloadValue = await getPayloadValue();
      String role = payloadValue['userRole'] ?? '';
      setState(() {
        _userRole = role;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _userRole = '';
        _isLoading = false;
      });
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await _bookingStatusController.fetchBookingDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        List<BookingDetailsData>? bookingDataList = _bookingStatusController.bookingDetailsModel.value.data ?? [];
        if (_bookingStatusController.isLoadingService.value) {
          return const Center(child: CustomPageLoading());
        } else if (bookingDataList.isEmpty) {
          return Center(child: Text('Not found any booking details'));
        }
        final bookingDetailsData = bookingDataList.first;
        bool pending = bookingDetailsData.status == 'pending';
        bool accepted = bookingDetailsData.status == 'accepted';
        bool completed = bookingDetailsData.status == 'completed';
        return BookingManagementWidget(
          userRole: _userRole,
          isReviewHistoryPageActive: true,
          isOrderCompleted: completed,
          markAsDoneTap: () {
            if(accepted){
               Get.toNamed(Routes.FEEDBACK);
            }else{
              Get.snackbar('Failed to mark as done', 'Seems that your order is not accepted yet');
            }
          },
          booking: BookingData(
            userId: '',
            name: bookingDetailsData.name ?? '',
            service: 'Hair Cut',
            address: bookingDetailsData.address ?? '',
            phone: bookingDetailsData.phone ?? '',
            time: bookingDetailsData.time ?? '',
            rating: bookingDetailsData.avgRating?.toStringAsFixed(1) ?? '',
            imageUrl: '',
            orderId: bookingDetailsData.orderId ?? '',
            items: bookingDetailsData.services?.map((serviceItem) {
                  return OrderItem(
                    name: serviceItem.name ?? '',
                    price: serviceItem.price ?? 0,
                    quantity: 0,
                  );
                }).toList() ?? [],
            serviceFee: 0,
            subtotal: 0,
            total: bookingDetailsData.totalPrice ?? 0,
            statuses: [
              BookingStatus(
                title: 'Booking Placed',
                timestamp: '',
                isCompleted: pending || accepted || completed
                    ? true
                    : false,
              ),
              BookingStatus(
                title: 'In progress',
                timestamp: '',
                isCompleted: accepted || completed ? true : false,
              ),
              BookingStatus(
                title: 'Worked Done',
                timestamp: '',
                isCompleted: completed ? true : false,
              ),
            ],
          ),
        );
      }),
    );
  }
}

// /// =================> Review Section <==================
// Padding(
//   padding: EdgeInsets.all(16.w),
//   child: Column(
//     mainAxisSize: MainAxisSize.min,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         'Review',
//         style: GoogleFontStyles.h5(
//           color: Colors.white,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       SizedBox(height: 16.h),
//       ReviewHistoryCard(),
//       SizedBox(height: 16.h),
//     ],
//   ),
// )