
import 'package:barberita/app/modules/authentication/views/verify_phone_view.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/app_logo/app_logo.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/widgets/custom_textbutton_with_icon.dart';
import 'package:barberita/common/widgets/dont_have_an_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barberita/common/app_color/app_colors.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:barberita/common/widgets/custom_text_field.dart';
import 'package:get/get.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30.h),
                // Logo
                AppLogo(),
                SizedBox(height: 50.h),
                // Form Fields
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Phone Number Field
                    Text(
                      'Phone Number',
                      style: GoogleFontStyles.h5(
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: _phoneController,
                      hintText: 'Enter Your phone Number',
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10)
                      ],
                      hintStyle: GoogleFontStyles.h5(
                        color: Colors.white.withOpacity(0.5),
                      ),
                      fillColor: Colors.transparent,
                      keyboardType: TextInputType.phone,
                    ),

                    SizedBox(height: 24.h),

                    // Password Field
                    Text(
                      'Password',
                      style: GoogleFontStyles.h5(
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: '••••••••••',
                      isPassword: true,
                      hintStyle: GoogleFontStyles.h5(
                        color: Colors.white.withOpacity(0.5),
                      ),
                      fillColor: Colors.transparent,
                    ),

                    SizedBox(height: 16.h),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VerifyPhoneVIew(),
                            ),
                          );
                        },
                        child: Text(
                          'Forgot Password',
                          style: GoogleFontStyles.h5(
                            color: Colors.red.withOpacity(0.8),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40.h),

                // Log In Button
                CustomButton(
                  onTap: () {
                    // Add login logic here
                    if (_phoneController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty) {
                      // Navigate to home or show success
                      print('Phone: ${_phoneController.text}');
                      print('Password: ${_passwordController.text}');
                    }
                  },
                  text: 'Log In',
                  textStyle: GoogleFontStyles.h4(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 32.h),

                // Or Log In With
                Text(
                  'Or Log In With',
                  style: GoogleFontStyles.h5(
                    color: Colors.white.withOpacity(0.7),
                    fontWeight: FontWeight.w400,
                  ),
                ),

                SizedBox(height: 24.h),

                // Face-ID Button
                CustomTextButtonWithIcon(
                  onTap: () {},
                  text: 'Face-ID',
                  color: AppColors.secondaryAppColor,
                  height: 50.h,
                  icon: Icon(Icons.face, color: Colors.white, size: 24.sp),
                ),

                SizedBox(height: 16.h),

                // OR
                Text(
                  'OR',
                  style: GoogleFontStyles.h5(
                    color: Colors.white.withOpacity(0.7),
                    fontWeight: FontWeight.w400,
                  ),
                ),

                SizedBox(height: 16.h),

                // Touch-ID Button
                CustomTextButtonWithIcon(
                  onTap: () {},
                  text: 'Face-ID',
                  height: 50.h,
                  color: AppColors.secondaryAppColor,
                  icon: Icon(
                    Icons.fingerprint,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ),

                SizedBox(height: 16.h),

                // Sign Up Link
                DontHaveAnAccount(onTap: () {Get.toNamed(Routes.SIGNUP);}),

                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
