import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// About Tab Widget
class AboutTab extends StatelessWidget {
  const AboutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hairdresser Name
          Text(
            'Hairdresser: John Doew',
            style: GoogleFontStyles.h4(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),

          // Working Hours
          Text(
            'Working Hour: 9AM - 9PM',
            style: GoogleFontStyles.h5(
              color: Colors.white.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 16.h),

          // Experience
          Row(
            children: [
              Icon(
                Icons.workspace_premium,
                color: const Color(0xFFE6C4A3),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Experience 3 Years',
                style: GoogleFontStyles.h5(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Description
          Text(
            'John Doe is a professional hairdresser, known for his skilled haircuts and grooming services. With years of experience in the industry, he specializes in both traditional and modern styles, offering a wide range of services to meet your hairdressing and grooming needs.\n\nJohn, John is passionate about creating personalized, high-quality services through creative and meticulous styling, leaving you feeling fresh and confident. His attention to detail and friendly manner make him a trusted choice for those looking for a top-tier barbering experience...... ',
            style: GoogleFontStyles.h5(
              color: Colors.white.withOpacity(0.8),
              height: 1.5,
            ),
          ),
          SizedBox(height: 16.h),

          // See More Button
          GestureDetector(
            onTap: () {},
            child: Text(
              'See More',
              style: GoogleFontStyles.h5(
                color: const Color(0xFFE6C4A3),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
