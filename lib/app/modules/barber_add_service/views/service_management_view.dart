import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/bottom_menu/bottom_menu..dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'barber_add_service_view.dart';

// Service Management Screen
class ServiceManagementView extends StatefulWidget {
  const ServiceManagementView({super.key});

  @override
  State<ServiceManagementView> createState() => _ServiceManagementViewState();
}

class _ServiceManagementViewState extends State<ServiceManagementView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(child: BottomMenu(1)),
      appBar: CustomAppBar(title: 'Service Management',),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Active Hour Section
            Row(
              children: [
                Text('Active Hour:', style: GoogleFontStyles.h6(color: Colors.white.withOpacity(0.7))),
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: () => _showEditHourDialog(),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2C2E),
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('9:00 AM - 9:00 PM', style: GoogleFontStyles.h6(color: Colors.white)),
                        SizedBox(width: 8.w),
                        Icon(Icons.edit, color: const Color(0xFFE6C4A3), size: 16.sp),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),

            // Add Your Service Section
            Text('Add Your Service', style: GoogleFontStyles.h5(color: Colors.white, fontWeight: FontWeight.w600)),

            SizedBox(height: 16.h),

            // Latest Upload Container
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2E),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Latest Upload', style: GoogleFontStyles.h6(color: Colors.white.withOpacity(0.7))),
                  SizedBox(height: 16.h),

                  // Service Items
                  _buildServiceItem(
                    'assets/images/service1.jpg',
                    'Marty\'s Barbershop',
                    'Haircut',
                    'Open Now',
                    '\$2.99-\$500',
                    true,
                  ),
                  SizedBox(height: 16.h),

                  _buildServiceItem(
                    'assets/images/service2.jpg',
                    'Marty\'s Barbershop',
                    'Haircut',
                    'Open Now',
                    '\$2.99-\$500',
                    true,
                  ),
                  SizedBox(height: 16.h),

                  _buildServiceItem(
                    'assets/images/service3.jpg',
                    'Marty\'s Barbershop',
                    'Haircut',
                    'Open Now',
                    '\$2.99-\$500',
                    true,
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            // Add More Service Button
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const BarberAddServiceView()));
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.white, size: 24.sp),
                    SizedBox(width: 8.w),
                    Text('Add More Service', style: GoogleFontStyles.h5(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem(String imagePath, String title, String subtitle, String status, String price, bool isActive) {
    return Row(
      children: [
        // Service Image
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Image.asset(
            imagePath,
            width: 60.w,
            height: 60.h,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 60.w,
                height: 60.h,
                color: Colors.grey[600],
                child: Icon(Icons.cut, color: Colors.white, size: 30.sp),
              );
            },
          ),
        ),

        SizedBox(width: 12.w),

        // Service Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFontStyles.h6(color: Colors.white, fontWeight: FontWeight.w600)),
              Text(subtitle, style: GoogleFontStyles.customSize(size: 10.sp, color: const Color(0xFFE6C4A3))),
              Text(status, style: GoogleFontStyles.customSize(size: 10.sp, color: Colors.green)),
              SizedBox(height: 4.h),
              Text('Price Range: $price', style: GoogleFontStyles.customSize(size: 9.sp, color: Colors.white.withOpacity(0.7))),
            ],
          ),
        ),

        // Toggle and Edit
        Column(
          children: [
            Switch(
              value: isActive,
              onChanged: (value) {
                setState(() {
                  // Handle toggle
                });
              },
              activeColor: Colors.green,
              inactiveThumbColor: Colors.grey,
            ),
            SizedBox(height: 4.h),
            GestureDetector(
              onTap: () {
                // Handle edit
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF55493E),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.edit, color: Colors.white, size: 12.sp),
                    SizedBox(width: 4.w),
                    Text('Edit', style: GoogleFontStyles.customSize(size: 10.sp, color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showEditHourDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2E),
        title: Text('Edit Your Active Hour', style: GoogleFontStyles.h4(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTimeField('Start Time', '09:00 AM'),
            SizedBox(height: 16.h),
            _buildTimeField('End Time', '09:00 PM'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFontStyles.h5(color: Colors.white.withOpacity(0.7))),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(color: const Color(0xFF55493E), borderRadius: BorderRadius.circular(6.r)),
              child: Text('Update', style: GoogleFontStyles.h5(color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeField(String label, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFontStyles.h6(color: Colors.white.withOpacity(0.7))),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Expanded(child: Text(time, style: GoogleFontStyles.h5(color: Colors.white))),
              Icon(Icons.access_time, color: Colors.white.withOpacity(0.5), size: 20.sp),
            ],
          ),
        ),
      ],
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2E),
        title: Text('Log Out', style: GoogleFontStyles.h4(color: Colors.white)),
        content: Text('Do you want to log out your profile?', style: GoogleFontStyles.h5(color: Colors.white.withOpacity(0.8))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFontStyles.h5(color: Colors.white.withOpacity(0.7))),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Handle logout
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6.r)),
              child: Text('Log Out', style: GoogleFontStyles.h5(color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}