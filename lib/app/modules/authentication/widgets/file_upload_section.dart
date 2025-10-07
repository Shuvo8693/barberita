import 'package:barberita/app/modules/authentication/widgets/uploaded_file_item.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Model class for uploaded file
class UploadedFile {
  final String name;
  final String size;
  final bool isComplete;
  final bool hasError;

  UploadedFile({
    required this.name,
    required this.size,
    required this.isComplete,
    required this.hasError,
  });
}

// File Upload Section Widget
class FileUploadSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<UploadedFile> uploadedFiles;
  final VoidCallback? onChooseFile;

  const FileUploadSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.uploadedFiles,
    this.onChooseFile,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          // Dashed Border Upload Area
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[600]!,
                width: 2,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                Text(
                  title,
                  style: GoogleFontStyles.h4(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Text(
                  subtitle,
                  style: GoogleFontStyles.h6(
                    color: Colors.grey[400],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  text: 'Choose File',
                  onTap: onChooseFile ?? () {},
                  width: 120.w,
                ),
              ],
            ),
          ),

          SizedBox(height: 20.h),

          // Uploaded Files List
          ...uploadedFiles.map((file) => UploadedFileItem(file: file)),
        ],
      ),
    );
  }
}

