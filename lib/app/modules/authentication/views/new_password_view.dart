import 'package:barberita/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/app_images/app_svg.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:barberita/common/widgets/custom_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class NewPasswordView extends StatefulWidget {
  const NewPasswordView({super.key});

  @override
  State<NewPasswordView> createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends State<NewPasswordView> {
  final AuthenticationController _authenticationController = Get.put(AuthenticationController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40.h),
                  // Lock Icon with Stars
                  SvgPicture.asset(AppSvg.unlockSvg,height: 125.h,),
                  SizedBox(height: 40.h),
                  // Title
                  Text(
                    'New Password',
                    style: GoogleFontStyles.h2(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Subtitle
                  Text(
                    'For Security Enter Your New 8 Character Password.',
                    textAlign: TextAlign.center,
                    style: GoogleFontStyles.h6(
                      color: Colors.white.withOpacity(0.7),
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                  ),

                  SizedBox(height: 40.h),
                  // Form Fields
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Password Field
                      Text(
                        'Password',
                        style: GoogleFontStyles.h6(
                          color: Colors.white.withOpacity(0.7),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        controller: _authenticationController.newPassCtrl,
                        hintText: '••••••••••',
                        isPassword: true,
                        hintStyle: GoogleFontStyles.h6(
                          color: Colors.white.withOpacity(0.5),
                        ),
                        fillColor: Colors.transparent,
                      ),

                      SizedBox(height: 24.h),

                      // Confirm Password Field
                      Text(
                        'Confirm Password',
                        style: GoogleFontStyles.h6(
                          color: Colors.white.withOpacity(0.7),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        controller: _authenticationController.confirmPassCtrl,
                        hintText: '••••••••••',
                        isPassword: true,
                        hintStyle: GoogleFontStyles.h6(
                          color: Colors.white.withOpacity(0.5),
                        ),
                        fillColor: Colors.transparent,
                        validator: (value){
                          if(!value!.contains(_authenticationController.newPassCtrl.text)){
                            return "Password doesn't match";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 40.h),

                  // Continue Button
                  CustomButton(
                    onTap: () async{
                      if(_formKey.currentState!.validate()){
                       await _authenticationController.resetPassword();
                      }
                    },
                    text: 'Continue',
                    textStyle: GoogleFontStyles.h4(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _authenticationController.confirmPassCtrl.dispose();
    _authenticationController.newPassCtrl.dispose();
    super.dispose();
  }
}