import 'package:barberita/app/modules/booking_management/controllers/booking_management_controller.dart';
import 'package:barberita/app/modules/booking_management/model/booking_details_model.dart';
import 'package:barberita/app/modules/booking_management/widgets/BookingManagementWidget.dart';
import 'package:barberita/app/modules/booking_management/model/booking_management_models.dart';
import 'package:barberita/common/jwt_decoder/payload_value.dart';
import 'package:barberita/common/prefs_helper/prefs_helpers.dart';
import 'package:barberita/common/widgets/custom_page_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class BookingManagementView extends StatefulWidget {
  const BookingManagementView({super.key});

  @override
  State<BookingManagementView> createState() => _BookingManagementViewState();
}

class _BookingManagementViewState extends State<BookingManagementView> {
  final BookingManagementController _bookingManagementController = Get.put(BookingManagementController());

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
        String role = payloadValue['userRole']??'';
      setState(() {
        _userRole = role ;
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
  void didChangeDependencies() async{
    super.didChangeDependencies();
   await _bookingManagementController.fetchBookingDetails();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CustomPageLoading());
    }
    return Obx((){
      List<BookingDetailsData>?  bookingDataList = _bookingManagementController.bookingDetailsModel.value.data??[];
      if(_bookingManagementController.isLoadingService.value){
        return const Center(child: CustomPageLoading());
      } else if(bookingDataList.isEmpty){
        return Center(child: Text('Not found any booking details'));
      }
      final bookingDetailsData = bookingDataList.first;
      return BookingManagementWidget(
        userRole: _userRole,
        booking: BookingData(
          name: bookingDetailsData.name??'',
          service: 'Hair Cut',
          address: bookingDetailsData.address??'',
          phone:  bookingDetailsData.phone??'',
          time:  bookingDetailsData.time??'',
          rating:  bookingDetailsData.avgRating?.toStringAsFixed(1)??'',
          imageUrl: '',
          orderId: bookingDetailsData.orderId??'',
          items: bookingDetailsData.services?.map((serviceItem){
            return OrderItem(name: serviceItem.name??'', price: serviceItem.price??0, quantity: 0);
          }).toList()??[],
          serviceFee: 0,
          subtotal: 0,
          total:bookingDetailsData.totalPrice??0,
          statuses: [
            BookingStatus(title: 'Booking Placed', timestamp: '20 Dec 2025, 11:20 PM',isCompleted: true),
            BookingStatus(title: 'In progress', timestamp: '20 Dec 2025, 12:20 PM', isCompleted: false),
            BookingStatus(title: 'Worked Done', timestamp: '20 Dec 2025, 1:20 PM', isCompleted: false),
          ],
        ),
      );
     }
    );
  }
}

