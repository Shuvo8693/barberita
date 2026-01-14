import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:barberita/common/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 2. Change Password Screen
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Change Password',),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 40.h),

                // Old Password
                CustomTextField(
                  controller: _oldPasswordController,
                  hintText: 'Old Password',
                  isPassword: true,
                  fillColor: const Color(0xFF2C2C2E),
                  hintStyle: GoogleFontStyles.h5(color: Colors.white.withOpacity(0.5)),
                  validator: (String? value){
                    if(value!.isEmpty){
                      return 'Enter your old password';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20.h),

                // New Password
                CustomTextField(
                  controller: _newPasswordController,
                  hintText: 'Enter New Password',
                  isPassword: true,
                  fillColor: const Color(0xFF2C2C2E),
                  hintStyle: GoogleFontStyles.h5(color: Colors.white.withOpacity(0.5)),
                ),

                SizedBox(height: 20.h),

                // Confirm New Password
                CustomTextField(
                  controller: _confirmPasswordController,
                  hintText: 'Re-Enter New Password',
                  isPassword: true,
                  fillColor: const Color(0xFF2C2C2E),
                  hintStyle: GoogleFontStyles.h5(color: Colors.white.withOpacity(0.5),
                  ),
                  validator: (String? value){
                    if(value != _newPasswordController.text){
                      return 'Password doesn\'t match';
                    }
                    return null;
                  },
                ),

                const Spacer(),

                // Confirm Button
                CustomButton(
                  onTap: () {
                    // Handle password change
                    if (_formKey.currentState!.validate()) {

                      Navigator.pop(context);
                    }
                  },
                  text: 'Confirm',
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

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}