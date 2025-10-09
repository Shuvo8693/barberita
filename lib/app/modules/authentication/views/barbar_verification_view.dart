import 'dart:io';

import 'package:barberita/app/modules/authentication/widgets/file_upload_section.dart';
import 'package:barberita/app/modules/authentication/widgets/uploaded_file_item.dart';
import 'package:barberita/common/app_color/app_colors.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:barberita/common/file_picker/file_picker_service.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BarberVerificationView extends StatefulWidget {
  const BarberVerificationView({super.key});

  @override
  State<BarberVerificationView> createState() => _BarberVerificationViewState();
}

class _BarberVerificationViewState extends State<BarberVerificationView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> iqamaFilePathsList = [];
  List<String> healthFilePathsList = [];

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
                    'Choose Your Identity first',
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
                    onChooseFile: () {
                      pickFileWithChoice(context, isIqama: true);
                    },
                    child: Column(
                      children: [
                        ...List.generate(iqamaFilePathsList.length, (index) {
                          String iqamaFilePathItem = iqamaFilePathsList[index];
                          return UploadedFileItem(
                            uploadedFile: UploadedFile(
                              name: iqamaFilePathItem.split('/').last,
                              file: iqamaFilePathItem,
                            ),
                            removeOnTap: () {
                              setState(() {
                                iqamaFilePathsList.removeAt(index);
                              });
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                  // Health Certificate Tab
                  FileUploadSection(
                    title: 'Health Certificate',
                    subtitle: 'JPEG, PNG, PDF Formats Up to 25MB',
                    onChooseFile: () {
                      pickFileWithChoice(context, isIqama: false);
                    },
                    child: Column(
                      children: [
                        ...List.generate(healthFilePathsList.length, (index) {
                          String healthFilePathItem = healthFilePathsList[index];
                          return UploadedFileItem(
                            uploadedFile: UploadedFile(
                              name: healthFilePathItem.split('/').last,
                              file: healthFilePathItem,
                            ),
                            removeOnTap: () {
                              setState(() {
                                healthFilePathsList.removeAt(index);
                              });
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Continue Button (Fixed at bottom, outside TabView)
            Padding(
              padding: EdgeInsets.all(20.w),
              child: CustomButton(
                text: 'Continue to Sign up',
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

  // file picker bottomSheet
  Future<void> pickFileWithChoice(BuildContext context, {bool? isIqama}) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.secondaryAppColor,
      builder: (context) => SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.picture_as_pdf),
                title: Text('Choose an PDF'),
                onTap: () async {
                  Navigator.pop(context);
                  File? file = await FilePickerService.pickPDF();
                  if (file != null) {
                    setState(() {
                      if (isIqama == true) {
                        iqamaFilePathsList.add(file.path);
                      } else {
                        healthFilePathsList.add(file.path);
                      }
                    });
                    print('Photo taken: ${file.path}');
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  File? image = await FilePickerService.pickImageFromGallery();
                  if (image != null) {
                    print('Image selected: ${image.path}');
                    setState(() {
                      if (isIqama == true) {
                        iqamaFilePathsList.add(image.path);
                      } else {
                        healthFilePathsList.add(image.path);
                      }
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
