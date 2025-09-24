import 'package:barberita/app/modules/notification/widgets/notification_item.dart';
import 'package:barberita/app/modules/notification/widgets/payment_card.dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Notification'),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          NotificationItem(
            icon: Icons.notifications_outlined,
            title: "You have a new appointment request from....",
            time: "30 Mins ago",
            isUnread: true,
          ),
          SizedBox(height: 12.h),
          NotificationItem(
            icon: Icons.calendar_today_outlined,
            title: "You have an appointment with....",
            time: "1 Hour ago",
            isUnread: true,
          ),
          SizedBox(height: 12.h),
          NotificationItem(
            icon: Icons.payment_outlined,
            title: "You've received payment for completed....",
            time: "3 Hours ago",
            isUnread: true,
          ),
          SizedBox(height: 12.h),
          NotificationItem(
            icon: Icons.attach_money_outlined,
            title: "You've paid money for completed....",
            time: "Yesterday",
            isUnread: false,
          ),
          SizedBox(height: 12.h),
          NotificationItem(
            icon: Icons.check_circle_outline,
            title: "Your appointment has been confirmed with....",
            time: "Yesterday",
            isUnread: false,
          ),
          SizedBox(height: 12.h),
          PaymentRequestCard(
            name: "Courtney Henry",
            subtitle: "User request to receive the money",
            time: "Yesterday",
            avatarUrl: "assets/images/avatar.jpg",
          ),
        ],
      ),
    );
  }
}



