import 'package:barberita/app/modules/booking/widgets/booking_list.dart';
import 'package:barberita/common/app_color/app_colors.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/bottom_menu/bottom_menu..dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BarberHomeView extends StatefulWidget {
  const BarberHomeView({super.key});

  @override
  State<BarberHomeView> createState() => _BarberHomeViewState();
}

class _BarberHomeViewState extends State<BarberHomeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
      appBar: CustomAppBar(title: 'Bookings'),
      body: Column(
        children: [
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
    );
  }
}
