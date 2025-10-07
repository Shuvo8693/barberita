
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationSelectorBottomSheet extends StatelessWidget {
  final List<Widget> buttons;

  const LocationSelectorBottomSheet({super.key, required this.buttons});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Location',
              style: GoogleFontStyles.h4(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20.h),
            ...buttons,
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
