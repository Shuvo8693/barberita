import 'dart:convert';
import 'dart:io';

import 'package:barberita/app/data/api_constants.dart';
import 'package:barberita/app/data/network_caller.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/prefs_helper/prefs_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AuthenticationController extends GetxController {


  final NetworkCaller _networkCaller = NetworkCaller.instance;
  RxBool isLoading = false.obs;
  LatLng? currentLocation;
  String? currentAddress;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  createUser() async {
    final role = await PrefsHelper.getString('role');
    final body = {
      "name" : nameController.text,
      "phone" : phoneController.text,
      "password" : confirmPasswordController.text,
      "longitude": currentLocation?.longitude,
      "latitude" : currentLocation?.latitude
    };

    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoading.value = true;
      final response = await _networkCaller.post<Map<String, dynamic>>(
        endpoint: ApiConstants.registerUrl,
        body: body,
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
        Get.snackbar('Success', response.message ?? 'User creation successfully done ',);
        String token = response.data!['data']['token'];
        await PrefsHelper.setString('token', token).then((value){
          return Get.toNamed(Routes.OTP);

        });

      } else {
        Get.snackbar('Failed', response.message ?? 'User creation failed ');
        //throw NetworkException(response.message ?? 'User creation failed ');
      }
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  /// ======================== Create barber ================================

  List<String> iqamaFilePathsList = [];
  List<String> healthFilePathsList = [];

  createBarber() async {

    final role = await PrefsHelper.getString('role');

    Map<String,String> body = {
      "name" : nameController.text,
      "phone" : phoneController.text,
      "password" : confirmPasswordController.text,
      "longitude": currentLocation?.longitude.toString()??'',
      "latitude" : currentLocation?.latitude.toString()??''
    };

    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoading.value = true;
      // residancePermit
      final residancePermit = await MultipartFile.fromFile(
        field: 'residancePermit',
        file: File(iqamaFilePathsList.first),
        contentType: getContentType(iqamaFilePathsList.first),
      );
      // healthCertificate
      final healthCertificate = await MultipartFile.fromFile(
        field: 'healthCertificate',
        file: File(healthFilePathsList.first),
        contentType: getContentType(healthFilePathsList.first),
      );

      final response = await _networkCaller.multipart<Map<String, dynamic>>(
        endpoint: ApiConstants.registerBarberUrl,
        files: [residancePermit,healthCertificate],
        fields: body,
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
        Get.snackbar('Success', response.message ?? 'User creation successfully done ',);
        String token = response.data!['data']['token'];
        await PrefsHelper.setString('token', token).then((value){
          return Get.toNamed(Routes.OTP);

        });

      } else {
        Get.snackbar('Failed', response.message ?? 'User creation failed ');
        //throw NetworkException(response.message ?? 'User creation failed ');
      }
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  /// ====================== Verify phone =================================

  TextEditingController verifyPhoneCtrl = TextEditingController();

  RxBool isLoadingVerifyPhone = false.obs;
  RxString errorMessage = ''.obs;

  Future<void> verifyPhone({bool isResetPass=false}) async {

    final body = {
      "phone": verifyPhoneCtrl.text.trim(),
    };

    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoadingVerifyPhone.value = true;
      final response = await _networkCaller.post<Map<String, dynamic>>(
        endpoint: ApiConstants.phoneSendUrl,
        body: body,
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
        String token = response.data!['data']['token'];
        print(" token : $token ");
        await PrefsHelper.setString('token', token).then((value)async{
          Get.toNamed(
            Routes.OTP,
            arguments: {
              'phone': verifyPhoneCtrl.text,
              'isResetPass': isResetPass ,
            },
          );
        });
      } else {
        Get.snackbar('Failed', response.message ?? 'User login failed ');
      }
    } catch (e) {
      print(e);
      throw NetworkException('$e');
    } finally {
      isLoadingVerifyPhone.value = false;
    }

  }


 /// ================================== Sign in ================================

  TextEditingController phoneLoginCtrl = TextEditingController();
  TextEditingController passLoginCtrl = TextEditingController();
  RxBool isLoadingSignIn = false.obs;

  Future<void> signIn() async {

    final body = {
      "phone": phoneLoginCtrl.text.trim(),
      "password": passLoginCtrl.text.trim()
    };

    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoadingSignIn.value = true;
      final response = await _networkCaller.post<Map<String, dynamic>>(
        endpoint: ApiConstants.logInUrl,
        body: body,
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
        String token = response.data!['data']['token'];
        String role = response.data!['data']['user']['role'];
        print('role: $role , token : $token ');
        await PrefsHelper.setString('role', role);
        await PrefsHelper.setString('token', token).then((value)async{
          String? userRole =await PrefsHelper.getString('role');
          if(userRole =='customer'){
            Get.toNamed(Routes.HOME);
          } else if(userRole =='barber'){
            Get.toNamed(Routes.BARBER_HOME);
          }else{
            Get.snackbar('Failed to route', ' Login again or create account');
          }
        });
      } else {
        Get.snackbar('Failed', response.message ?? 'User login failed ');
      }
    } catch (e) {
      print(e);
      throw NetworkException('$e');
    } finally {
      isLoadingSignIn.value = false;
    }

  }

  /// ================================== Reset password ================================


  TextEditingController newPassCtrl = TextEditingController();
  TextEditingController confirmPassCtrl = TextEditingController();
  var isLoadingResetPass = false.obs;

  Future<void> resetPassword({ Function( String)? responseMessage}) async {
    String token = await PrefsHelper.getString('token');
    var body = {
      "password": confirmPassCtrl.text.trim(),
    };

    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoadingResetPass.value = true;
      final response = await _networkCaller.post<Map<String, dynamic>>(
        endpoint:ApiConstants.resetPasswordUrl,
        body: body,
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
        String message = response.data!['message'];
        Get.offAndToNamed(Routes.SIGNIN);
        Get.snackbar('Successfully', message );
      } else {
        Get.snackbar('Failed', response.message ?? 'Resend otp failed');
      }
    } catch (e) {
      print(e);
      throw NetworkException('$e');
    } finally {
      isLoadingResetPass.value = false;
    }

  }

}



