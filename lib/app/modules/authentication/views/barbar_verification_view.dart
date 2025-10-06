import 'package:barberita/common/app_color/app_colors.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BarberVerificationView extends StatefulWidget {
  const BarberVerificationView({super.key});

  @override
  State<BarberVerificationView> createState() => _BarberVerificationViewState();
}

class _BarberVerificationViewState extends State<BarberVerificationView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Verification'),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Choose Your Identity Section
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose Your Identity',
                    style: GoogleFontStyles.h4(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Tab Bar
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        color: AppColors.secondaryAppColor,
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerHeight: 0,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.white70,
                      labelStyle: GoogleFontStyles.h6(
                        fontWeight: FontWeight.w500,
                      ),
                      unselectedLabelStyle: GoogleFontStyles.h6(),
                      tabs: [
                        Tab(text: 'Iqama/Residence Permit'),
                        Tab(text: 'Health Certificate'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // TabBarView for File Upload Area
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Iqama/Residence Permit Tab
                  _buildFileUploadSection(
                    title: 'Upload Iqama/Residence Permit',
                    subtitle: 'JPEG, PNG, PDF Formats Up to 25MB',
                    uploadedFiles: [
                      UploadedFile(
                        name: 'Iqama Photo.jpeg',
                        size: '30 kb of 121 kb',
                        isComplete: false,
                        hasError: true,
                      ),
                      UploadedFile(
                        name: 'Residence Permit.pdf',
                        size: '121 kb of 121 kb',
                        isComplete: true,
                        hasError: false,
                      ),
                    ],
                  ),

                  // Health Certificate Tab
                  _buildFileUploadSection(
                    title: 'Health Certificate',
                    subtitle: 'JPEG, PNG, PDF Formats Up to 25MB',
                    uploadedFiles: [
                      UploadedFile(
                        name: 'Health Certificate.jpeg',
                        size: '40 kb of 121 kb',
                        isComplete: false,
                        hasError: true,
                      ),
                      UploadedFile(
                        name: 'Health Certificate.pdf',
                        size: '121 kb of 121 kb',
                        isComplete: true,
                        hasError: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Continue Button (Fixed at bottom, outside TabView)
            Padding(
              padding: EdgeInsets.all(20.w),
              child: CustomButton(
                text: 'Continue',
                onTap: () {
                  // Handle continue action
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileUploadSection({
    required String title,
    required String subtitle,
    required List<UploadedFile> uploadedFiles,
  }) {
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
                  onTap: () {
                    // Handle file selection
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: 20.h),

          // Uploaded Files List
          ...uploadedFiles.map((file) => _buildUploadedFileItem(file)),
        ],
      ),
    );
  }

  Widget _buildUploadedFileItem(UploadedFile file) {
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
              file.name.contains('.pdf') ? Icons.picture_as_pdf : Icons.image,
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
                  file.name,
                  style: GoogleFontStyles.h5(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  file.size,
                  style: GoogleFontStyles.h6(
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),

          // Status Icon
          Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: file.isComplete ? Colors.green : (file.hasError ? Colors.red : Colors.blue),
              shape: BoxShape.circle,
            ),
            child: Icon(
              file.isComplete ? Icons.check : (file.hasError ? Icons.close : Icons.more_horiz),
              color: Colors.white,
              size: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}

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