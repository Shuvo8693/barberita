import 'package:barberita/app/data/api_constants.dart';
import 'package:barberita/app/modules/booking/widgets/booking_list.dart';
import 'package:barberita/app/modules/notification/controllers/notification_controller.dart';
import 'package:barberita/app/modules/notification/model/unreadAndLatestNotification_model.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/app_color/app_colors.dart';
import 'package:barberita/common/app_images/network_image%20.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/bottom_menu/bottom_menu..dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:barberita/common/widgets/casess_network_image.dart';
import 'package:barberita/common/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BarberHomeView extends StatefulWidget {
  const BarberHomeView({super.key});

  @override
  State<BarberHomeView> createState() => _BarberHomeViewState();
}

class _BarberHomeViewState extends State<BarberHomeView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final NotificationController _notificationController = Get.put(NotificationController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _notificationController.fetchBadgeCount();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(child: BottomMenu(0)),
      body: SafeArea(
        child: Column(
          children: [
            //  ============== Header Section ====================
            Obx((){
              UnreadLatestData? unreadLatestData = _notificationController.unreadAndLatestNotificationModel.value.data;
               final badgeCount =unreadLatestData?.unreadCount??0;
              return Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Header
                    Row(
                      children: [
                        CustomNetworkImage(
                          imageUrl: "${ApiConstants.baseUrl}${unreadLatestData?.userInfo?.image??''}",
                          boxShape: BoxShape.circle,
                          height: 38.h,
                          width: 38.w,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                unreadLatestData?.userInfo?.name??'',
                                style: GoogleFontStyles.h5(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              // Text(
                              //   '112/23 Park Street',
                              //   style: GoogleFontStyles.h6(
                              //     color: Colors.white.withOpacity(0.7),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.NOTIFICATION);
                          },
                          child:badgeCount < 1 ? Icon(
                            Icons.notifications_outlined,
                            color: Colors.white,
                            size: 24.sp,
                          ): Badge.count(
                            count: badgeCount ,
                            child: Icon(
                              Icons.notifications_outlined,
                              color: Colors.white,
                              size: 24.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              );
             }
            ),
            // Tab Bar
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: AppColors.secondaryAppColor,
                  borderRadius: BorderRadius.circular(25.r),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white.withOpacity(0.6),
                labelStyle: GoogleFontStyles.h6(fontWeight: FontWeight.w600),
                unselectedLabelStyle: GoogleFontStyles.h6(
                  fontWeight: FontWeight.w400,
                ),
                tabs: [
                  Tab(child: const Text('Booking Request')),
                  Tab(child: const Text('Active Order')),
                  Tab(child: const Text('History')),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            // Tab Bar View
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  BookingList(statusType: BookingStatusType.request),
                  BookingList(statusType: BookingStatusType.active),
                  BookingList(statusType: BookingStatusType.history),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
