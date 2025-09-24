import 'package:barberita/app/modules/customer_profile/views/settings/privacy_policy_screen.dart';
import 'package:barberita/app/modules/customer_profile/views/settings/terms_service_screen.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 3. About Us Screen
class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'About',),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About Us',
                style: GoogleFontStyles.h4(color: Colors.white, fontWeight: FontWeight.w600),
              ),

              SizedBox(height: 20.h),

              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2E),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'Lorem ipsum dolor sit amet consectetur. Lacus at vestibulum gravida rhoncus mauris. Quisque mi est vel dis. Donec rhoncus lorem auctor sed enim est elit. Consequat condimentum gravida et facilisis elementum aliquet. At vel porttitor eget vehicula tincidunt rutrum aliquet malesuada. Elementum ultricies venenatis at neque dis. Gravida accumsan mauris tellus est proin. Volutpat in accumsan veit lorem rutrum placerat auctor. Sed lorem est a et ex orci. Non rutrum ornare ut cursus vel tempus aliquet vitae placerat condimentum ut et dignissim.\n\nVel blandit sit risus molestis consecuetur. Egestas rhoncus sodales ut at mauris magna aenean. Cursus consequat et platea phasellus sit. Facilisi consequat ut orci mauris facilisis in. Lorem ornare et dignissim aliquet lorem sed mauris porttitor auctor.\n\nSuscipit nullis at mollis consequat condimentum molestie. Consequat ut adipiscing at urna ultricies mauris vestibulum orci. Arcu mauris lorem orci adipiscing et massa. Ut molestie lorem consequat porttitor. mauris vestibulum cursus vel cursus tellus non aliquet lorem consequat porttitor lorem mauris vestibulum cursus vel cursus tellus non aliquet lorem consequat porttitor lorem. Nulla alias duis elit et imperdiet lacusta. Mauris auctor lacinia nulla morbi elit. Molestie cursus cursus adipiscing. Lorem quis prorem cum qui qui posuere. Pretium pulvinar mauris suscipit mauris.',
                  style: GoogleFontStyles.h6(
                    color: Colors.white.withOpacity(0.8),
                    height: 1.6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}