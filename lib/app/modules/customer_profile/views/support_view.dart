import 'package:barberita/common/All_launcher/all_launcher.dart';
import 'package:barberita/common/app_images/app_svg.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Support Screen
class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Support',),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            // Support Illustration
            SvgPicture.asset(AppSvg.supportFemaleSvg,height: 140.h,),

            SizedBox(height: 32.h),

            Text(
              'If you face any kind of problem with\nour service feel free to contact us.',
              textAlign: TextAlign.center,
              style: GoogleFontStyles.h5(
                color: Colors.white.withOpacity(0.8),
                height: 1.5,
              ),
            ),

            SizedBox(height: 40.h),

            // Contact Options
            _buildContactButton(
              icon: Icons.email_outlined,
              label: 'Email',
              onTap: () async{
                // Handle email contact
               await LauncherHelper.sendEmail(
                     email: 'shuvo.office52@gmail.com',
                     subject: 'Hello',
                     body: 'This is the email body',
                   );
              },
            ),

            SizedBox(height: 16.h),

            _buildContactButton(
              icon: Icons.call_outlined,
              label: 'Call',
              onTap: () {
                // Handle call contact
                LauncherHelper.makePhoneCall('+1234567890');
              },
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildContactButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24.sp),
            SizedBox(width: 16.w),
            Text(
              label,
              style: GoogleFontStyles.h5(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}