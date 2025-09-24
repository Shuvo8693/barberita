import 'package:barberita/common/app_images/network_image%20.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/widgets/casess_network_image.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentRequestCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final String time;
  final String avatarUrl;

  const PaymentRequestCard({
    super.key,
    required this.name,
    required this.subtitle,
    required this.time,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
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
              CustomNetworkImage(imageUrl: AppNetworkImage.saloonHairMen4Img,height: 40.h,width: 40.w,boxShape: BoxShape.circle,),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFontStyles.h4(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: GoogleFontStyles.h6(
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
              Text(
                time,
                style: GoogleFontStyles.h6(
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Accept',
                  height: 40.h,
                  onTap: () {
                    // Handle accept action
                  },
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomButton(
                  text: 'Decline',
                  height: 40.h,
                  onTap: () {
                    // Handle decline action
                  },
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}