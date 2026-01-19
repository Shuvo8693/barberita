import 'package:barberita/app/modules/customer_profile/controllers/settings_controller.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:barberita/common/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

// 2. Change Password Screen
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _settingController = Get.find<SettingsController>();
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
                  controller: _settingController.oldPassCtrl,
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
                  controller: _settingController.newPassCtrl,
                  hintText: 'Enter New Password',
                  isPassword: true,
                  fillColor: const Color(0xFF2C2C2E),
                  hintStyle: GoogleFontStyles.h5(color: Colors.white.withOpacity(0.5)),
                ),

                SizedBox(height: 20.h),

                // Confirm New Password
                CustomTextField(
                  controller: _settingController.confirmPassCtrl,
                  hintText: 'Re-Enter New Password',
                  isPassword: true,
                  fillColor: const Color(0xFF2C2C2E),
                  hintStyle: GoogleFontStyles.h5(color: Colors.white.withOpacity(0.5),
                  ),
                  validator: (String? value){
                    if(value != _settingController.newPassCtrl.text){
                      return 'Password doesn\'t match';
                    }
                    return null;
                  },
                ),

                const Spacer(),

                // Confirm Button
                Obx((){
                return CustomButton(
                  loading: _settingController.isLoadingChangePass.value,
                    onTap: () async {
                      // Handle password change
                      if (_formKey.currentState!.validate()) {
                        await _settingController.changePassword();
                      }
                    },
                    text: 'Confirm',
                    textStyle: GoogleFontStyles.h4(color: Colors.white, fontWeight: FontWeight.w600),
                    color: const Color(0xFF55493E),
                    borderRadius: 12.r,
                    height: 56.h,
                  );
                }

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}