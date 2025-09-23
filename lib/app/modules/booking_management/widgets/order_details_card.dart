import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/app/modules/booking_management/model/booking_management_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'BookingManagementWidget.dart';

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