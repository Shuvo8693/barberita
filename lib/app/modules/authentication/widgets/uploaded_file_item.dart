
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Model class for uploaded file
class UploadedFile {
  final String name;
  final String file;

  UploadedFile({
    required this.name,
    required this.file,

  });
}


// Uploaded File Item Widget
class UploadedFileItem extends StatelessWidget {
  final UploadedFile uploadedFile;
  final VoidCallback removeOnTap;

  const UploadedFileItem({
    super.key,
    required this.uploadedFile,
    required this.removeOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.grey[800]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // File Icon
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              uploadedFile.name.contains('.pdf') ? Icons.picture_as_pdf : Icons.image,
              color: Colors.white70,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),

          // File Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  uploadedFile.name,
                  style: GoogleFontStyles.h5(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  uploadedFile.file,
                  style: GoogleFontStyles.h6(
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),

          // Status Icon
          GestureDetector(
            onTap: removeOnTap,
            child: Container(
              width: 20.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: Colors.red ,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close ,
                color: Colors.white,
                size: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
