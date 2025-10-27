import 'package:barberita/app/modules/booking_management/widgets/BookingManagementWidget.dart';
import 'package:barberita/app/modules/booking_management/model/booking_management_models.dart';
import 'package:barberita/common/jwt_decoder/jwt_decoder.dart';
import 'package:barberita/common/prefs_helper/prefs_helpers.dart';
import 'package:barberita/common/widgets/custom_page_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BookingManagementView extends StatefulWidget {
  const BookingManagementView({super.key});

  @override
  State<BookingManagementView> createState() => _BookingManagementViewState();
}

class _BookingManagementViewState extends State<BookingManagementView> {

  String _userRole = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    try {
      final role = await PrefsHelper.getString('role');
      setState(() {
        _userRole = role ?? '';
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
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CustomPageLoading());
    }
    return BookingManagementWidget(
      userRole: _userRole,
      booking: BookingData(
        name: 'Darlene Robertson',
        service: 'Hair Cut',
        address: '112/23 Jeddah, Saudi Arabia',
        phone: '+1234 554 8723',
        time: '4:00 PM - 5:00 PM',
        rating: '4.5',
        imageUrl: 'assets/images/hairdresser.jpg',
        orderId: '#012 578 471',
        items: [OrderItem(name: 'Hair Cut', price: 5.99, quantity: 1)],
        serviceFee: 5.99,
        subtotal: 5.99,
        total: 5.99,
        statuses: [
          BookingStatus(title: 'Booking Placed', timestamp: '20 Dec 2025, 11:20 PM', isCompleted: true),
          BookingStatus(title: 'In progress', timestamp: '20 Dec 2025, 12:20 PM', isCompleted: true),
          BookingStatus(title: 'Worked Done', timestamp: '20 Dec 2025, 1:20 PM', isCompleted: false),
        ],
      ),
    );
  }
}

