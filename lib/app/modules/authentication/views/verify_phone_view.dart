import 'package:barberita/app/modules/authentication/views/otp_view.dart';
import 'package:barberita/common/app_images/app_svg.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barberita/common/app_color/app_colors.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:barberita/common/widgets/custom_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerifyPhoneVIew extends StatefulWidget {
  const VerifyPhoneVIew({super.key});

  @override
  State<VerifyPhoneVIew> createState() => _VerifyPhoneVIewState();
}

class _VerifyPhoneVIewState extends State<VerifyPhoneVIew> {
  final TextEditingController _phoneController = TextEditingController();

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
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50.h),

                    // Lock with Key Icon
                    SvgPicture.asset(AppSvg.lockSvg,height: 125.h,),

                    SizedBox(height: 40.h),

                    // Title
                    Text(
                      'Forgot Password?',
                      style: GoogleFontStyles.h2(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Subtitle
                    Text(
                      'Don\'t worry! It happens. Please enter the phone number associated with your account.',
                      textAlign: TextAlign.center,
                      style: GoogleFontStyles.h5(
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                      ),
                    ),

                    SizedBox(height: 60.h),

                    // Phone Number Field
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                          hintText: 'Enter your phone number',
                          hintStyle: GoogleFontStyles.h5(
                            color: Colors.white.withOpacity(0.5),
                          ),
                          fillColor: Colors.transparent,
                          keyboardType: TextInputType.phone,
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(12.w),
                            child: Icon(
                              Icons.phone,
                              color: Colors.white.withOpacity(0.5),
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const Spacer(flex: 3,),

                    // Send Code Button
                    CustomButton(
                      onTap: () {
                        if (_phoneController.text.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  OtpView(),
                            ),
                          );
                        }
                      },
                      text: 'Send Code',
                      textStyle: GoogleFontStyles.h4(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Remember Password
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Remember your password? ',
                              style: GoogleFontStyles.h5(
                                color: Colors.white.withOpacity(0.7),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'Log In',
                              style: GoogleFontStyles.h5(
                                color: const Color(0xFFE6C4A3),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Spacer(flex: 4,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}