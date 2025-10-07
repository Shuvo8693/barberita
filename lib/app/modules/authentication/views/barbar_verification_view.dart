import 'package:barberita/app/modules/authentication/widgets/file_upload_section.dart';
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
                  FileUploadSection(
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
                  FileUploadSection(
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
}
