
import 'package:barberita/app/data/api_constants.dart';
import 'package:barberita/app/data/biometric/biometric_auth_service.dart';
import 'package:barberita/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:barberita/app/modules/authentication/controllers/biometric_controller.dart';
import 'package:barberita/app/modules/authentication/views/verify_phone_view.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/app_images/app_images.dart';
import 'package:barberita/common/app_logo/app_logo.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/prefs_helper/prefs_helpers.dart';
import 'package:barberita/common/widgets/custom_phone_field.dart';
import 'package:barberita/common/widgets/custom_textbutton_with_icon.dart';
import 'package:barberita/common/widgets/dont_have_an_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barberita/common/app_color/app_colors.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:barberita/common/widgets/custom_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../common/app_images/app_svg.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final AuthenticationController _authenticationController = Get.put(AuthenticationController());
  final BiometricController _biometricController =Get.put(BiometricController());
  final BiometricAuthService _biometricAuthService = BiometricAuthService();
  final _formKey = GlobalKey<FormState>();

@override
  void initState() {
    super.initState();
    role();
  }
  String? _userRole;
  role()async{
    final role = await PrefsHelper.getString('role');
    setState(() {
      _userRole = role;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30.h),
                  // Logo
                  // Image.asset(AppImage.barberLogoImg,height: 120.h),
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
                      CustomPhoneField(
                        controller: _authenticationController.phoneLoginCtrl,
                        initialCountry: "BD",
                        onChanged: (phone) {
                          print("Complete number: ${phone.completeNumber}");
                          _authenticationController.phoneNumber = phone.completeNumber ;
                          setState(() {});
                        },
                        onCountryChanged: (country) {
                          print("Country: ${country.name}");
                        },
                      ),
                      // CustomTextField(
                      //   controller: _authenticationController.phoneLoginCtrl,
                      //   hintText: 'Enter Your phone Number',
                      //   inputFormatters: [
                      //     // FilteringTextInputFormatter.digitsOnly,
                      //     // LengthLimitingTextInputFormatter(11)
                      //   ],
                      //   hintStyle: GoogleFontStyles.h5(
                      //     color: Colors.white.withOpacity(0.5),
                      //   ),
                      //   fillColor: Colors.transparent,
                      //   keyboardType: TextInputType.phone,
                      // ),
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
                        controller: _authenticationController.passLoginCtrl,
                        hintText: '••••••••••',
                        isPassword: true,
                        hintStyle: GoogleFontStyles.h5(
                          color: Colors.white.withOpacity(0.5),
                        ),
                        fillColor: Colors.transparent,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter your password';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 16.h),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                          Get.toNamed(Routes.VERIFYPHONE);
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
                  Obx((){
                    return CustomButton(
                      loading: _authenticationController.isLoadingSignIn.value,
                      onTap: () async{
                        if (_formKey.currentState!.validate()) {
                          await _authenticationController.signIn();
                        }
                      },
                      text: 'Log In',
                    );
                   }
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

                  // Touch-ID Button
                  CustomTextButtonWithIcon(
                    onTap: () async {
                     String? deviceId =  await BiometricAuthService.authenticateAndGetId();
                     if(deviceId != null && deviceId.isNotEmpty){
                       print(deviceId);
                       await _biometricController.biometricSignIn(deviceId: deviceId);
                     }
                    },
                    text: 'Touch-ID or Face-ID',
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
                  DontHaveAnAccount(
                      onTap: () {
                    Get.toNamed(Routes.ROLESELECTION);
                   }
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
    _authenticationController.phoneNumber = '';
    _authenticationController.passLoginCtrl.dispose();
    _authenticationController.phoneLoginCtrl.dispose();
    super.dispose();
  }
}
