import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/app_color/app_colors.dart';
import 'package:barberita/common/app_images/app_svg.dart';

class BottomMenu extends StatefulWidget {
  final int menuIndex;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  const BottomMenu(this.menuIndex, {super.key, this.scaffoldKey});

  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  late int _selectedIndex;
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.menuIndex; // Set initial index
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

   // FocusScope.of(context).unfocus();
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to corresponding pages
    switch (index)  {
      case 0 :
        Get.offAllNamed(Routes.HOME);
        break;
      case 1:
        Get.offAllNamed(Routes.BOOKING);
        break;
      case 2:
       Get.offAllNamed(Routes.CUSTOMER_PROFILE);
       //widget.scaffoldKey?.currentState!.openDrawer();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(100.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.r),
        child: BottomNavigationBar(
            currentIndex: _selectedIndex, // Set the selected index
            onTap: _onItemTapped, // Handle taps on items
            type: BottomNavigationBarType.fixed, // Prevents shifting behavior
            backgroundColor: Colors.transparent ,
            selectedItemColor: AppColors.white,
            unselectedItemColor: Colors.white, // Inactive item color
            showUnselectedLabels: true,
            showSelectedLabels: true,
            unselectedIconTheme: IconThemeData(color: Colors.black),

          selectedLabelStyle: GoogleFontStyles.h6(fontWeight: FontWeight.w600),
          unselectedLabelStyle: GoogleFontStyles.h6(fontWeight: FontWeight.w400),
          selectedFontSize: 12.sp,
          unselectedFontSize: 12.sp,
            items: [
              _buildBottomNavItem(AppSvg.homeSvg, 'Home'),
              _buildBottomNavItem(AppSvg.bookingSvg, 'Booking'),
              _buildBottomNavItem(AppSvg.personSvg, 'Profile'),
            ],
          ),
      ),
    );

  }

  BottomNavigationBarItem _buildBottomNavItem(String iconPath, String label) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        iconPath,
        height: 28.0.h,
        width: 28.0.w,
        colorFilter: const ColorFilter.mode(AppColors.greyColor, BlendMode.srcIn), // Inactive icon color
      ),
      activeIcon: SvgPicture.asset(
        iconPath,
        height: 30.0.h,
        width: 30.0.w,
        colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn), // Active icon color
      ),
      label: label,
    );
  }
}
