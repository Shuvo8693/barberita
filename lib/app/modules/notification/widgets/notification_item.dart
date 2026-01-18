import 'package:barberita/app/modules/booking_management/controllers/booking_management_controller.dart';
import 'package:barberita/app/modules/notification/model/notification_model.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/jwt_decoder/payload_value.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:barberita/common/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationItem extends StatefulWidget {
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
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  String? userRole ;
  @override
  void initState() {
    super.initState();
    getUserRole();
  }
  getUserRole()async{
    final result = await getPayloadValue();
    print(result['userRole']);
    userRole = result['userRole'];
  }

  @override
  Widget build(BuildContext context) {
    final bookingMngCtrl = Get.put(BookingManagementController());
    var userName  = userRole?.toLowerCase().contains('customer')==true
        ? widget.notificationItems.barberName??''
        : widget.notificationItems.customerName??'';
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
                  widget.icon,
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
                      widget.title,
                      style: GoogleFontStyles.h6(
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Text(" Name : $userName",
                          style: GoogleFontStyles.h6(
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: (){
                            if(widget.notificationItems.bookingId != null ){
                              Get.toNamed(Routes.BOOKING_MANAGEMENT,arguments: {'bookingGroupId':widget.notificationItems.bookingId});
                            }
                          },
                            child: Icon(Icons.arrow_circle_right_outlined))
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      widget.time,
                      style: GoogleFontStyles.h6(
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              if (widget.isUnread)
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
          if(widget.notificationItems.status != null &&  widget.notificationItems.status!.contains('mark_as_done'))
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Obx(()=>
              CustomButton(
                loading: bookingMngCtrl.isLoadingConfirmation[widget.index]??false,
                  onTap: ()async{
                    print(widget.notificationItems);
                    if(widget.notificationItems.bookingId !=null){
                      await bookingMngCtrl.confirmOrDeclineOrder(bookingGroupId: widget.notificationItems.bookingId,status: 'completed', index: widget.index );
                    }
                  },
                  height: 40.h,
                  text: 'Accept'
              ),
            ),
          )
         else if(widget.notificationItems.status != null &&  widget.notificationItems.status!.contains('completed'))
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Colors.grey[800]!,
                      width: 1,
                    ),
                  ),
                  child: Text('Order Completed')),
            )
        ],
      ),
    );
  }
}