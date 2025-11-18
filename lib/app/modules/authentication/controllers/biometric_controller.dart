
import 'package:barberita/app/data/api_constants.dart';
import 'package:barberita/app/data/network_caller.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/jwt_decoder/jwt_decoder.dart';
import 'package:barberita/common/prefs_helper/prefs_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BiometricController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller.instance;

  var isLoadingOtp = false.obs;

  Future<void> biometricSignup({String? deviceId}) async {
    String token = await PrefsHelper.getString('token');
    final payload = decodeJWT(token);
    String phone = payload['phone'];

    final body = {
      "deviceId" : deviceId
    };
    _networkCaller.clearInterceptors();
    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoadingOtp.value = true;
      final response = await _networkCaller.patch<Map<String, dynamic>>(
        endpoint: ApiConstants.addBiometricUrl,
        body: body,
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
        Get.snackbar('Successful', response.message ?? 'Biometric added successfully');
      } else {
        Get.snackbar('Failed', response.message ?? '');
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

    super.onClose();
  }

  /// ======================== biometric signin =======================

  var isLoadingBiometricSignin = false.obs;

  Future<void> biometricSignIn({String? deviceId}) async {
    String token = await PrefsHelper.getString('token');


    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoadingBiometricSignin.value = true;
      final response = await _networkCaller.post<Map<String, dynamic>>(
        endpoint: ApiConstants.loginBiometricUrl,
        body:{
          "deviceId" : deviceId
        },
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null){
        String role = response.data!['data']['role'];
        String token = response.data!['data']['token'];
        print("Check ===== Role: $role Token: $token");
        await PrefsHelper.setString('role',role);
        await PrefsHelper.setString('token',token);
        Get.snackbar('Success', response.message??'');
      } else {
        Get.snackbar('Failed', response.message ?? 'Resend otp failed');
      }
    } catch (e) {
      print(e);
      throw NetworkException('$e');
    } finally {
      isLoadingBiometricSignin.value = false;
    }

  }

}
