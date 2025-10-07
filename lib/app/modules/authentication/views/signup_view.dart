import 'package:barberita/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:barberita/app/modules/authentication/views/otp_view.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/app_logo/app_logo.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/widgets/have_an_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:barberita/common/widgets/custom_text_field.dart';
import 'package:get/get.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();

 final AuthenticationController _authenticationController = Get.put(AuthenticationController());

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

                  // Logo
                  AppLogo(),

                  SizedBox(height: 40.h),

                  // Form Fields
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Full Name Field
                      Text(
                        'Enter Your Full Name',
                        style: GoogleFontStyles.h5(
                          color: Colors.white.withOpacity(0.7),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        controller: _authenticationController.nameController,
                        hintText: 'Enter Your Full Name',
                        hintStyle: GoogleFontStyles.h5(
                          color: Colors.white.withOpacity(0.5),
                        ),
                        fillColor: Colors.transparent,
                      ),

                      SizedBox(height: 24.h),

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
                        controller: _authenticationController.phoneController,
                        hintText: 'Enter Your phone Number',
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(11)
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
                        controller: _authenticationController.passwordController,
                        hintText: '***********',
                        isPassword: true,
                        hintStyle: GoogleFontStyles.h5(
                          color: Colors.white.withOpacity(0.5),
                        ),
                        fillColor: Colors.transparent,
                      ),
                      SizedBox(height: 24.h),
                      // Confirm Password Field
                      Text(
                        'Confirm Password',
                        style: GoogleFontStyles.h5(
                          color: Colors.white.withOpacity(0.7),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        controller: _authenticationController.confirmPasswordController,
                        hintText: '***********',
                        isPassword: true,
                        hintStyle: GoogleFontStyles.h5(
                          color: Colors.white.withOpacity(0.5),
                        ),
                        fillColor: Colors.transparent,
                        validator: (String? value){
                          if(!value!.contains(_authenticationController.passwordController.text)){
                            return "Password doesn't match";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24.h),
                      // Sign Up Button
                      Obx((){
                        return CustomButton(
                          loading: _authenticationController.isLoading.value,
                          onTap: () async {
                            if(_formKey.currentState!.validate()){
                              await _authenticationController.createUser();
                            }
                          },
                          text: 'Sign Up',
                          textStyle: GoogleFontStyles.h4(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      }

                      ),

                      SizedBox(height: 24.h),

                      // Already have account
                      Align(
                        alignment: Alignment.center,
                          child: HaveAnAccountText(
                            onTap: (){
                            Get.offAllNamed(Routes.SIGNIN);
                            },
                          )
                      ),

                      SizedBox(height: 40.h),
                    ],
                  ),
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
    _authenticationController.nameController.dispose();
    _authenticationController.phoneController.dispose();
    _authenticationController.passwordController.dispose();
    _authenticationController.confirmPasswordController.dispose();
    super.dispose();
  }
}