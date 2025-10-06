
import 'package:barberita/app/data/api_constants.dart';
import 'package:barberita/app/data/network_caller.dart';
import 'package:barberita/common/prefs_helper/prefs_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller.instance;
  TextEditingController otpCtrl = TextEditingController();
  RxString otpErrorMessage=''.obs;
  var isLoading2 = false.obs;

  Future<void> sendOtp(bool? isResetPass) async {
    String token = await PrefsHelper.getString('token');
    String userMail = (Get.arguments != null && (Get.arguments['email'] as String).isNotEmpty) ? Get.arguments['email'] : '';
    final body = {
      "otp": otpCtrl.text.trim(),
    };
    _networkCaller.clearInterceptors();
    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoading2.value = true;
      final response = await _networkCaller.post<Map<String, dynamic>>(
        endpoint: isResetPass==true ? ApiConstants.verifyForgotOtpUrl(userMail) : ApiConstants.verifyOtpUrl,
        body: body,
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
        String role = await PrefsHelper.getString('role');
        String token = await PrefsHelper.getString('token');
        print('role: $role , token : $token');
        if(isResetPass==true){
          // Get.toNamed(Routes.CHANGE_PASSWORD,arguments: {'isResetPass': true});
        }else{
          if(role =='user'){
            //  Get.toNamed(Routes.SIGN_IN);
          } else if(role =='mechanic'){
            // Get.toNamed(Routes.SIGN_IN);
          }else{
            Get.snackbar('Failed route', ' Select your role before route home');
          }
        }

      } else {
        Get.snackbar('Failed', response.message ?? 'User verify failed ');
      }
    } catch (e) {
      print(e);
      throw NetworkException('$e');
    } finally {
      isLoading2.value = false;
    }

  }
  @override
  void onClose() {
    otpCtrl.dispose();
    super.onClose();
  }


  /// ========================Resend Otp =======================

  var isLoading3 = false.obs;

  Future<void> reSendOtp(bool? isResetPass) async {
    String token = await PrefsHelper.getString('token');

    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoading3.value = true;
      final response = await _networkCaller.post<Map<String, dynamic>>(
        endpoint: ApiConstants.resendOtpUrl,
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null){
        String  message = response.data!['message'];
        Get.snackbar('Success', message);
      } else {
        Get.snackbar('Failed', response.message ?? 'Resend otp failed');
      }
    } catch (e) {
      print(e);
      throw NetworkException('$e');
    } finally {
      isLoading3.value = false;
    }

  }

}
