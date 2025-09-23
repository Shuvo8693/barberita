import 'package:barberita/common/app_color/app_colors.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barberita/common/widgets/custom_button.dart';

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
                onTap: () => Navigator.pop(context),
                text: 'Back to Home',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Models
class BookingData {
  final String name, service, address, phone, time, rating, orderId;
  final String? imageUrl;
  final List<OrderItem> items;
  final double serviceFee, subtotal, total;
  final List<BookingStatus> statuses;

  BookingData({required this.name, required this.service, required this.address,
    required this.phone, required this.time, required this.rating, required this.orderId,
    this.imageUrl, required this.items, required this.serviceFee, required this.subtotal,
    required this.total, required this.statuses});
}

class OrderItem {
  final String name;
  final double price;
  final int quantity;
  OrderItem({required this.name, required this.price, this.quantity = 0});
}

class BookingStatus {
  final String title, timestamp;
  final bool isCompleted;
  BookingStatus({required this.title, required this.timestamp, this.isCompleted = false});
}

// Widgets
class HairdresserCard extends StatelessWidget {
  final BookingData booking;
  const HairdresserCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(color: const Color(0xFF2C2C2E), borderRadius: BorderRadius.circular(12.r)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: booking.imageUrl != null
                ? Image.asset(booking.imageUrl!, width: 60.w, height: 60.h, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _placeholder())
                : _placeholder(),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(booking.name, style: GoogleFontStyles.h5(color: Colors.white, fontWeight: FontWeight.w600))),
                    Icon(Icons.star, color: Colors.amber, size: 16.sp),
                    SizedBox(width: 4.w),
                    Text(booking.rating, style: GoogleFontStyles.h6(color: Colors.white)),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(booking.service, style: GoogleFontStyles.h6(color: Colors.white.withOpacity(0.7))),
                SizedBox(height: 8.h),
                _info('Address', booking.address),
                SizedBox(height: 4.h),
                _info('Phone Number', booking.phone),
                SizedBox(height: 4.h),
                _info('Today', booking.time),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() => Container(width: 60.w, height: 60.h, color: Colors.grey[600],
      child: Icon(Icons.person, color: Colors.white, size: 30.sp));

  Widget _info(String label, String value) => Row(
    children: [
      Text('$label:', style: GoogleFontStyles.h6(color: Colors.white.withOpacity(0.6))),
      SizedBox(width: 8.w),
      Expanded(child: Text(value, style: GoogleFontStyles.h6(color: Colors.white.withOpacity(0.9)))),
    ],
  );
}

class OrderDetailsCard extends StatelessWidget {
  final BookingData booking;
  const OrderDetailsCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Order Details', style: GoogleFontStyles.h5(color: Colors.white, fontWeight: FontWeight.w600)),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(color: const Color(0xFF2C2C2E), borderRadius: BorderRadius.circular(12.r)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Order ID: ${booking.orderId}', style: GoogleFontStyles.h6(color: Colors.white.withOpacity(0.7))),
              SizedBox(height: 16.h),
              ...booking.items.map((item) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: _row(item.quantity > 0 ? '${item.quantity}X' : '', item.name, '\$ ${item.price.toStringAsFixed(2)}'),
              )),
              _row('', 'Service Fee', '\$ ${booking.serviceFee.toStringAsFixed(2)}'),
              SizedBox(height: 12.h),
              _row('', 'Subtotal', '\$ ${booking.subtotal.toStringAsFixed(2)}'),
              SizedBox(height: 16.h),
              Divider(color: Colors.white.withOpacity(0.2)),
              SizedBox(height: 16.h),
              _row('', 'Total', '\$ ${booking.total.toStringAsFixed(2)}', isTotal: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _row(String qty, String item, String price, {bool isTotal = false}) => Row(
    children: [
      if (qty.isNotEmpty) ...[Text(qty, style: GoogleFontStyles.h6(color: Colors.white, fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400)), SizedBox(width: 8.w)],
      Expanded(child: Text(item, style: GoogleFontStyles.h6(color: Colors.white, fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400))),
      Text(price, style: GoogleFontStyles.h6(color: Colors.white, fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400)),
    ],
  );
}

class BookingStatusCard extends StatelessWidget {
  final List<BookingStatus> statuses;
  const BookingStatusCard({super.key, required this.statuses});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Booking Status', style: GoogleFontStyles.h5(color: Colors.white, fontWeight: FontWeight.w600)),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(color: const Color(0xFF2C2C2E), borderRadius: BorderRadius.circular(12.r)),
          child: Column(children: [
            for (int i = 0; i < statuses.length; i++)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status container
                  Column(children: [
                    Container(
                      width: 24.w, height: 24.h,
                      decoration: BoxDecoration(
                        color: statuses[i].isCompleted ? const Color(0xFF55493E) : Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(color: statuses[i].isCompleted ? const Color(0xFF55493E) : AppColors.secondaryAppColor, width: 2),
                      ),
                      child: statuses[i].isCompleted ? Icon(Icons.check, color: Colors.white, size: 14.sp) : null,
                    ),
                    if (i != statuses.length -1) Container(width: 2.w, height: 40.h, color: AppColors.secondaryAppColor),
                  ]),
                  SizedBox(width: 16.w),
                  // Status text
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(statuses[i].title, style: GoogleFontStyles.h5(color: Colors.white, fontWeight: FontWeight.w500)),
                          SizedBox(height: 4.h),
                          Text(statuses[i].timestamp, style: GoogleFontStyles.h6(color: Colors.white.withOpacity(0.6))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          ]),
        ),
      ],
    );
  }
}