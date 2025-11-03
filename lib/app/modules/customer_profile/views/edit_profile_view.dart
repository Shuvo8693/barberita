import 'package:barberita/app/modules/customer_profile/controllers/customer_profile_controller.dart';
import 'package:barberita/common/app_images/network_image%20.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:barberita/common/widgets/custom_text_field.dart';
import 'package:get/get.dart';

// Edit Profile Screen
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
final  CustomerProfileController _profileController = Get.put(CustomerProfileController());

@override
  void initState() {
    super.initState();
    _profileController.fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Edit Profile',),
      body: Obx((){
        _profileController.userInfoModel.value;
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  // Profile Image
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundImage:  NetworkImage(AppNetworkImage.saloonHairMen2Img),
                        backgroundColor: Colors.grey[600],
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2C2C2E),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(Icons.camera_alt, color: Colors.white, size: 14.sp),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  Text(
                    'John Cooper',
                    style: GoogleFontStyles.h4(color: Colors.white, fontWeight: FontWeight.w600),
                  ),

                  SizedBox(height: 4.h),

                  Text('willie@emilytarsai@gmail.com',
                    style: GoogleFontStyles.h6(color: Colors.white.withOpacity(0.7)),),

                  SizedBox(height: 32.h),

                  // Form Fields
                  _buildFormField('Full Name', _profileController.nameController!),
                  SizedBox(height: 16.h),
                  _buildFormField('Email', _profileController.emailController!),
                  SizedBox(height: 16.h),
                  // _buildFormField('Gender', genderController),
                  // SizedBox(height: 16.h),
                  _buildFormField('Mobile Number', _profileController.phoneController!),
                  SizedBox(height: 16.h),
                  _buildFormField('Address', _profileController.addressController!),
                  SizedBox(height: 16.h),
                  _buildFormField('Experience', _profileController.experiencesController!),
                  SizedBox(height: 16.h),
                  _buildFormField('About your skill', _profileController.aboutSkillsController!,maxLine: 4),

                  SizedBox(height: 40.h),

                  // Save Update Button
                  CustomButton(
                    onTap: () {
                      // Handle save update
                      Navigator.pop(context);
                    },
                    text: 'Save Update',
                    textStyle: GoogleFontStyles.h4(color: Colors.white, fontWeight: FontWeight.w600),
                    color: const Color(0xFF55493E),
                    borderRadius: 12.r,
                    height: 56.h,
                  ),
                ],
              ),
            ),
          ),
        );
       }
      ),
    );
  }

  Widget _buildFormField(String label, TextEditingController controller, {int? maxLine}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFontStyles.h6(color: Colors.white.withOpacity(0.7)),
        ),
        SizedBox(height: 8.h),
        CustomTextField(
          controller: controller,
          fillColor: const Color(0xFF2C2C2E),
          maxLines: maxLine??1,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _profileController.nameController!.dispose();
    _profileController.emailController!.dispose();
    _profileController.genderController!.dispose();
    _profileController.phoneController!.dispose();
    _profileController.addressController!.dispose();
    super.dispose();
  }
}