import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Notification',),
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
            avatarUrl: "assets/images/avatar.jpg", // Replace with your asset path
          ),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String time;
  final bool isUnread;

  const NotificationItem({
    super.key,
    required this.icon,
    required this.title,
    required this.time,
    this.isUnread = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.grey[800]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              color: Colors.white70,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          if (isUnread)
            Container(
              width: 8.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}

class PaymentRequestCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final String time;
  final String avatarUrl;

  const PaymentRequestCard({
    super.key,
    required this.name,
    required this.subtitle,
    required this.time,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.grey[800]!,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundImage: AssetImage(avatarUrl),
                onBackgroundImageError: (exception, stackTrace) {},
                child: avatarUrl.isEmpty
                    ? Icon(Icons.person, color: Colors.white70, size: 20.sp)
                    : null,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                time,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle accept action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Accept',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // Handle decline action
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white70,
                    side: BorderSide(color: Colors.grey[600]!),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Decline',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}