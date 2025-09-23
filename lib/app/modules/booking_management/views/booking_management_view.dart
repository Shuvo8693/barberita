import 'package:barberita/app/modules/booking_management/widgets/BookingManagementWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BookingManagementView extends StatefulWidget {
  const BookingManagementView({super.key});

  @override
  State<BookingManagementView> createState() => _BookingManagementViewState();
}

class _BookingManagementViewState extends State<BookingManagementView> {
  @override
  Widget build(BuildContext context) {
    return BookingManagementWidget(
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
