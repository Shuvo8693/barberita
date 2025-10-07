import 'package:barberita/app/data/api_constants.dart';
import 'package:barberita/app/data/network_caller.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/prefs_helper/prefs_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {


  final NetworkCaller _networkCaller = NetworkCaller.instance;
  RxBool isLoading = false.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  createUser() async {
    final role = await PrefsHelper.getString('role');
    final body = {
      "name" : nameController.text,
      "phone" : phoneController.text,
      "password" : confirmPasswordController.text
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

  /// ====================== Verify phone =================================

  TextEditingController emailCtrl = TextEditingController();

  RxBool isLoading2 = false.obs;
  RxString errorMessage = ''.obs;

  Future<void> verifyPhone({bool? isResetPass}) async {

    final body = {
      "email": emailCtrl.text.trim(),
    };

    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoading2.value = true;
      final response = await _networkCaller.post<Map<String, dynamic>>(
        endpoint: ApiConstants.emailSendUrl,
        body: body,
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
        String token = response.data!['data']['token'];
        String role = response.data!['data']['role'];
        print(" token : $token , role : $role");
        await PrefsHelper.setString('role', role);
        await PrefsHelper.setString('token', token).then((value)async{
          Get.toNamed(
            Routes.OTP,
            arguments: {
              'email': emailCtrl.text,
              'isResetPass': isResetPass ?? false,
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
      isLoading2.value = false;
    }

  }


 /// ================================== Sign in ================================

  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  RxBool isLoadingSignIn = false.obs;

  Future<void> signIn() async {

    final body = {
      "phone": phoneCtrl.text.trim(),
      "password": passCtrl.text.trim()
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
        String userId = response.data!['data']['user']['id'];
        print('role: $role , token : $token , userId : $userId');
        await PrefsHelper.setString('role', role);
        await PrefsHelper.setString('userId', userId);
        await PrefsHelper.setString('token', token).then((value)async{
          String? userRole =await PrefsHelper.getString('role');
          if(userRole =='user'){
            // Get.toNamed(Routes.HOME);
          } else if(userRole =='mechanic'){
            // Get.toNamed(Routes.MECHANIC_HOME);
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

  Future<void> resetPassword({bool isResetPass = false, Function( String)? responseMessage}) async {
    String token = await PrefsHelper.getString('token');
    var body = {
      if(isResetPass==false)  // "oldPassword": oldPassCtrl.text.trim(),
      "newPassword": newPassCtrl.text.trim(),
      "confirmPassword": confirmPassCtrl.text.trim()
    };

    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoadingResetPass.value = true;
      final response = await _networkCaller.post<Map<String, dynamic>>(
        endpoint: isResetPass?ApiConstants.resetPasswordUrl : ApiConstants.changePasswordUrl,
        body: body,
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
        String message = response.data!['message'];
        if(isResetPass){
          // Get.offAndToNamed(Routes.SIGN_IN);
        }else{
          responseMessage!(message);
          Get.snackbar('Success', message);
        }
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

  @override
  void onClose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.onClose();
  }

}



