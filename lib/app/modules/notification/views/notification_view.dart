import 'package:barberita/app/modules/notification/controllers/notification_controller.dart';
import 'package:barberita/app/modules/notification/model/notification_model.dart';
import 'package:barberita/app/modules/notification/widgets/notification_item.dart';
import 'package:barberita/app/modules/notification/widgets/payment_card.dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:barberita/common/date_time_formation/data_age_formation.dart';
import 'package:barberita/common/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  // Get your controller
  final _notificationCtrl = Get.find<NotificationController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Notification'),
      body: Obx(() {
        List<NotificationItems> notificationItemList= _notificationCtrl.notificationModel.value.data?.notifications??[];
        if (_notificationCtrl.isLoadingNotification.value) {
          return Center(
            child: CustomLoading(),
          );
        }
        // Empty state
        if (notificationItemList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications_off_outlined,
                  size: 80.w,
                  color: Colors.grey,
                ),
                SizedBox(height: 16.h),
                Text(
                  'No Notifications',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'You don\'t have any notifications yet',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }
        // Data state
        return ListView.builder(
          padding: EdgeInsets.all(16.w),
          itemCount: notificationItemList.length,
          itemBuilder: (BuildContext context, int index) {
            final notificationItem = notificationItemList[index];
            return Padding(
              padding:  EdgeInsets.all(8.0.sp),
              child: NotificationItem(
                icon: Icons.notifications_outlined,
                title: notificationItem.msg ?? "Notification",
                time: DateAgeFormation.formatAge(DateTime.parse(notificationItem.createdAt??'')),
                notificationItems: notificationItem,
                // isUnread: notificationItem.isUnread ?? false,
              ),
            );
          },
        );
      }),
    );
  }
}