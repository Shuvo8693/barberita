
import 'package:barberita/app/modules/authentication/controllers/otp_controller.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/app_images/app_svg.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:barberita/common/app_color/app_colors.dart';
import 'package:barberita/common/widgets/custom_button.dart';

import 'dart:async';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  final OtpController _otpController = Get.put(OtpController());

  int _resendCountdown = 30;
  Timer? _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _canResend = false;
    _resendCountdown = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendCountdown > 0) {
          _resendCountdown--;
        } else {
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }


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
            child: Column(
              children: [
                SizedBox(height: 60.h),
                // Lock Icon
                SvgPicture.asset(AppSvg.unlockSvg,height: 125.h,),
                SizedBox(height: 40.h),

                Text(
                  'Enter Your Verification Code.',
                  style: GoogleFontStyles.h4(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 60.h),

                // Pin Code Field
                PinCodeTextField(
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.number,
                  controller: _otpController.otpCtrl,
                  autoDisposeControllers: false,
                  enablePinAutofill: false,
                  appContext: context,
                  autoFocus: true,
                  textStyle: GoogleFontStyles.h3(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8.r),
                    fieldHeight: 45.h,
                    fieldWidth: 45.w,
                    activeFillColor: AppColors.fillColor.withOpacity(0.1),
                    selectedFillColor: Colors.transparent,
                    inactiveFillColor: Colors.transparent,
                    borderWidth: 1.5,
                    errorBorderColor: Colors.red,
                    activeBorderWidth: 1.5,
                    selectedColor: const Color(0xFFE6C4A3),
                    inactiveColor: Colors.white.withOpacity(0.3),
                    activeColor: const Color(0xFFE6C4A3),
                  ),
                  length: 6,
                  enableActiveFill: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your pin code';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                ),

                SizedBox(height: 40.h),

                // Resend Code
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'You can request a new code ',
                      style: GoogleFontStyles.h5(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      _canResend ? 'in 30 sec' : 'in $_resendCountdown sec',
                      style: GoogleFontStyles.h5(
                        color: _canResend ? const Color(0xFFE6C4A3) : Colors.white.withOpacity(0.5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: _canResend ? _startCountdown : null,
                  child: Text(
                    'Resend Code',
                    style: GoogleFontStyles.h5(
                      color: _canResend ? const Color(0xFFE6C4A3) : Colors.white.withOpacity(0.5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                Obx((){
                  return CustomButton(
                    loading: _otpController.isLoadingOtp.value,
                    onTap : () async {
                      if (_otpController.otpCtrl.text.length == 6) {
                        await _otpController.sendOtp();
                      }
                    },
                    text: 'Verify',
                    textStyle: GoogleFontStyles.h4(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
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

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }
}