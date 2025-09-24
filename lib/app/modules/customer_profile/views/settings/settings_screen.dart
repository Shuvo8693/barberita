import 'package:barberita/app/modules/customer_profile/views/settings/privacy_policy_screen.dart';
import 'package:barberita/app/modules/customer_profile/views/settings/terms_service_screen.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barberita/common/app_color/app_colors.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:barberita/common/widgets/custom_text_field.dart';

import 'about_screen.dart';
import 'change_password_screen.dart';

// 1. Settings Screen
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Settings',),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              _buildMenuItem(
                icon: Icons.lock_outline,
                title: 'Change Password',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordScreen()));
                },
              ),
              SizedBox(height: 16.h),

              _buildMenuItem(
                icon: Icons.info_outline,
                title: 'About Us',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutUsScreen()));
                },
              ),
              SizedBox(height: 16.h),

              _buildMenuItem(
                icon: Icons.description_outlined,
                title: 'Terms and Services',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const TermsServicesScreen()));
                },
              ),
              SizedBox(height: 16.h),

              _buildMenuItem(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()));
                },
              ),

              const Spacer(),

              // Delete Account Button
              GestureDetector(
                onTap: () => _showDeleteAccountDialog(context),
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.red.withOpacity(0.3), width: 1),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.delete_outline, color: Colors.red, size: 24.sp),
                      SizedBox(width: 16.w),
                      Text('Delete Account', style: GoogleFontStyles.h5(color: Colors.red, fontWeight: FontWeight.w500)),
                      const Spacer(),
                      Icon(Icons.arrow_forward_ios, color: Colors.red, size: 16.sp),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({required IconData icon, required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2E),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24.sp),
            SizedBox(width: 16.w),
            Text(title, style: GoogleFontStyles.h5(color: Colors.white, fontWeight: FontWeight.w500)),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, color: Colors.white.withOpacity(0.5), size: 16.sp),
          ],
        ),
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2E),
        title: Text('Delete account', style: GoogleFontStyles.h4(color: Colors.white, fontWeight: FontWeight.w600)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Delete Account', style: GoogleFontStyles.h5(color: Colors.white, fontWeight: FontWeight.w600)),
            SizedBox(height: 8.h),
            Text(
              'Do you want to Delete your profile?',
              style: GoogleFontStyles.h6(color: Colors.white.withOpacity(0.8)),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFontStyles.h5(color: Colors.white.withOpacity(0.7))),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Handle account deletion
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6.r)),
              child: Text('Delete', style: GoogleFontStyles.h5(color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}







