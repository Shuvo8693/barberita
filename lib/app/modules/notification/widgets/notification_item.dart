import 'package:barberita/app/modules/booking_management/controllers/booking_management_controller.dart';
import 'package:barberita/app/modules/notification/model/notification_model.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:barberita/common/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String time;
  final bool isUnread;
  final bool isMarkAsDone;
  final NotificationItems notificationItems;
  final int index;

  const NotificationItem({
    super.key,
    required this.icon,
    required this.title,
    required this.time,
    this.isUnread = false,
    this.isMarkAsDone = false,
    required this.notificationItems,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final bookingMngCtrl = Get.put(BookingManagementController());
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
                      style: GoogleFontStyles.h5(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      time,
                      style: GoogleFontStyles.h6(
                        color: Colors.grey[400],
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
          if(notificationItems.status != null &&  notificationItems.status!.contains('mark_as_done'))
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Obx(()=>
              CustomButton(
                loading: bookingMngCtrl.isLoadingConfirmation[index]??false,
                  onTap: ()async{
                    print(notificationItems);
                    if(notificationItems.bookingId !=null){
                      await bookingMngCtrl.confirmOrDeclineOrder(bookingGroupId: notificationItems.bookingId,status: 'completed', index: index );
                    }
                  },
                  height: 40.h,
                  text: 'Accept'
              ),
            ),
          )
        ],
      ),
    );
  }
}