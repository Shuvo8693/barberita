
import 'package:barberita/app/data/api_constants.dart';
import 'package:barberita/app/data/network_caller.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/jwt_decoder/jwt_decoder.dart';
import 'package:barberita/common/prefs_helper/prefs_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller.instance;
  TextEditingController otpCtrl = TextEditingController();
  RxString otpErrorMessage=''.obs;
  var isLoadingOtp = false.obs;

  Future<void> sendOtp({bool isResetPass = false}) async {
    String token = await PrefsHelper.getString('token');
     // String userMail = (Get.arguments != null && (Get.arguments['email'] as String).isNotEmpty) ? Get.arguments['email'] : '';
    final body = {
      "otp": otpCtrl.text.trim(),
    };
    _networkCaller.clearInterceptors();
    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoadingOtp.value = true;
      final response = await _networkCaller.post<Map<String, dynamic>>(
        endpoint: ApiConstants.verifyOtpUrl,
        body: body,
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
       String role = response.data!['data']['role'];
       String token = response.data!['data']['token'];
       print("Check ===== Role: $role Token: $token");
       await PrefsHelper.setString('role',role);
       await PrefsHelper.setString('token',token);
        if(isResetPass){
          // Get.toNamed(Routes.CHANGE_PASSWORD,arguments: {'isResetPass': true});
        }else{
          if(role =='customer'){
             Get.toNamed(Routes.HOME);
          } else if(role =='barber'){
            Get.toNamed(Routes.BARBER_HOME);
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
      isLoadingOtp.value = false;
    }

  }
  @override
  void onClose() {
    otpCtrl.dispose();
    super.onClose();
  }


  /// ========================Resend Otp =======================

  var isLoadingResendOtp = false.obs;

  Future<void> reSendOtp({bool isResetPass = false}) async {
    String token = await PrefsHelper.getString('token');
    final payload = decodeJWT(token);
    print(payload);
    String phone = payload['phone'];

    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoadingResendOtp.value = true;
      final response = await _networkCaller.post<Map<String, dynamic>>(
        endpoint: ApiConstants.resendOtpUrl,
        body: {
          "phone" : phone
        },
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
      isLoadingResendOtp.value = false;
    }

  }

}
