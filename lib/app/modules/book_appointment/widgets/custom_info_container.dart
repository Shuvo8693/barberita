import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomInfoContainer extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? textColor;
  final Color? iconColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final double? iconSize;
  final bool hasError;
  final String? errorMessage;

  const CustomInfoContainer({
    super.key,
    required this.text,
    required this.icon,
    this.textColor,
    this.iconColor,
    this.backgroundColor,
    this.onTap,
    this.iconSize,
    this.hasError = false,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: backgroundColor ?? const Color(0xFF2C2C2E),
              borderRadius: BorderRadius.circular(8.r),
              border: hasError
                  ? Border.all(color: Colors.red, width: 1.5)
                  : null,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: GoogleFontStyles.h5(
                      color: hasError
                          ? Colors.red
                          : (textColor ?? Colors.white),
                    ),
                  ),
                ),
                Icon(
                  icon,
                  color: hasError
                      ? Colors.red
                      : (iconColor ?? Colors.white.withOpacity(0.7)),
                  size: iconSize ?? 24.sp,
                ),
              ],
            ),
          ),
        ),
        if (hasError && errorMessage != null) ...[
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 16.sp,
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  errorMessage!,
                  style: GoogleFontStyles.h5(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}