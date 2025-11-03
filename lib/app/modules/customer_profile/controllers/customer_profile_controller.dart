
import 'package:barberita/app/data/api_constants.dart';
import 'package:barberita/app/data/network_caller.dart';
import 'package:barberita/app/modules/customer_profile/model/user_info_model.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/prefs_helper/prefs_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile;

class CustomerProfileController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller.instance;
  RxBool isLoadingLogOut = false.obs;
  RxString errorMessage = ''.obs;

  Future<void> logout() async {
    String token = await PrefsHelper.getString('token');

    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());
    try {
      isLoadingLogOut.value = true;
      final response = await _networkCaller.get<Map<String, dynamic>>(
        endpoint: ApiConstants.logOutUrl,
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
        String token = response.data!['data']['token'];
        print(" token : $token ");
        await PrefsHelper.setString('token', token).then((value){
          Get.offAllNamed(Routes.SPLASH);
        });
      } else {
        String message = response.data!['message'];
        if(message.contains('expired')){
          Get.offAllNamed(Routes.SIGNIN);
        }else{
          Get.snackbar('Failed', response.message ?? 'User login failed ');
        }
      }
    } catch (e) {
      print(e);
      throw NetworkException('$e');
    } finally {
      isLoadingLogOut.value = false;
    }

  }

  /// =============== Fetch profile =======================

   TextEditingController? nameController ;
   TextEditingController? emailController ;
   TextEditingController? genderController ;
   TextEditingController? phoneController ;
   TextEditingController? addressController ;
   TextEditingController? experiencesController ;
   TextEditingController? aboutSkillsController ;

  RxBool isLoadingProfile = false.obs;
  Rx<UserInfoModel> userInfoModel  =UserInfoModel().obs;
  Future<void> fetchProfile() async {
    String token = await PrefsHelper.getString('token');

    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoadingProfile.value = true;
      final response = await _networkCaller.get<Map<String, dynamic>>(
        endpoint: ApiConstants.profileUrl,
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
        userInfoModel.value = UserInfoModel.fromJson(response.data!);
        print(userInfoModel.value);
        showUserInfo(userInfoModel:userInfoModel.value );
      } else {
        Get.snackbar('Failed', response.message ?? '');
      }
    } catch (e) {
      print(e);
      throw NetworkException('$e');
    } finally {
      isLoadingProfile.value = false;
    }

  }

  showUserInfo({UserInfoModel? userInfoModel} ){
    UserInfoData? userInfoData = userInfoModel?.data;
      nameController = TextEditingController(text: userInfoData?.name??'');
      emailController = TextEditingController(text: userInfoData?.email??'');
      // genderController = TextEditingController(text: 'emilytarsai@gmail.com');
      phoneController = TextEditingController(text: userInfoData?.phone??'');
      experiencesController = TextEditingController(text: userInfoData?.experience.toString()??'');
      aboutSkillsController = TextEditingController(text: userInfoData?.about??'');

      addressController = TextEditingController(text: userInfoData?.address??'');
  }
}

