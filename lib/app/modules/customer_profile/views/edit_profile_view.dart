import 'package:barberita/common/app_images/network_image%20.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:barberita/common/widgets/custom_text_field.dart';

// Edit Profile Screen
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController(text: 'Emily Tarsai');
  final TextEditingController _emailController = TextEditingController(text: 'emilytarsai@gmail.com');
  final TextEditingController _genderController = TextEditingController(text: 'emilytarsai@gmail.com');
  final TextEditingController _phoneController = TextEditingController(text: '+1234 5678 0874');
  final TextEditingController _addressController = TextEditingController(text: '112/23 Park Street');
  final TextEditingController _experiencesController = TextEditingController(text: '3 years');
  final TextEditingController _aboutSkillsController = TextEditingController(text: 'about my skill iam lks hkld');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Edit Profile',),
      body: SafeArea(
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

                Text(
                  'willie@emilytarsai@gmail.com',
                  style: GoogleFontStyles.h6(color: Colors.white.withOpacity(0.7)),
                ),

                SizedBox(height: 32.h),

                // Form Fields
                _buildFormField('Full Name', _nameController),
                SizedBox(height: 16.h),
                _buildFormField('Email', _emailController),
                SizedBox(height: 16.h),
                _buildFormField('Gender', _genderController),
                SizedBox(height: 16.h),
                _buildFormField('Mobile Number', _phoneController),
                SizedBox(height: 16.h),
                _buildFormField('Address', _addressController),
                SizedBox(height: 16.h),
                _buildFormField('Experience', _experiencesController),
                SizedBox(height: 16.h),
                _buildFormField('About your skill', _aboutSkillsController,maxLine: 4),

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
    _nameController.dispose();
    _emailController.dispose();
    _genderController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}