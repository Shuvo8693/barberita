
import 'dart:io';

import 'package:barberita/app/data/api_constants.dart';
import 'package:barberita/app/data/network_caller.dart';
import 'package:barberita/app/modules/customer_profile/model/user_info_model.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/file_picker/file_picker_service.dart';
import 'package:barberita/common/jwt_decoder/jwt_decoder.dart';
import 'package:barberita/common/prefs_helper/prefs_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile;

class CustomerProfileController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller.instance;
  RxBool isLoadingLogOut = false.obs;
  RxString errorMessage = ''.obs;

  Future<void> logout() async {
    String token = await PrefsHelper.getString('token');
    final response = decodeJWT(token);
    String  userId = response['id'];


    _networkCaller.clearInterceptors();
    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());
    try {
      isLoadingLogOut.value = true;
      final response = await _networkCaller.get<Map<String, dynamic>>(
        endpoint: ApiConstants.logOutUrl(userId: userId),
        timeout: Duration(seconds: 15),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
        String token = response.data!['data']['token'];
        print(" token : $token ");
        await PrefsHelper.setString('token', token).then((value){
          Get.offAllNamed(Routes.SPLASH);
        });
      } else {
        String message = response.data?['message']??'';
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
        showUserInfo(userInfoModel: userInfoModel.value);
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


 /// ============================= update user info ==========================

  TextEditingController? nameController ;
  TextEditingController? emailController ;
  TextEditingController? genderController ;
  TextEditingController? phoneController ;
  TextEditingController? addressController ;
  TextEditingController? experiencesController ;
  TextEditingController? aboutSkillsController ;
  String? coverImagePath;
  String? profileImagePath;
  RxBool isLoadingUpdateUserInfo = false.obs;

  Future<void> updateUserInfo({String? role}) async {
    String token = await PrefsHelper.getString('token');

    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

     Map<String, String> fields = {
      "name": ?nameController?.text,
      "phone": ?phoneController?.text,
      "email": ?emailController?.text,
      // "gender": "male",
      "address": ?addressController?.text,
      "experience": ?experiencesController?.text,
      "about": ?aboutSkillsController?.text,
       // "isOpen": true.toString()
    };

    MultipartFile? multipartCoverFile;
    if (coverImagePath != null && coverImagePath!.isNotEmpty) {
      multipartCoverFile = await MultipartFile.fromFile(
        field: 'barberCover',
        file: File(coverImagePath!),
        contentType: 'image/jpeg',
      );
    }

    MultipartFile? multipartProfileFile;
    if (profileImagePath != null && profileImagePath!.isNotEmpty) {
      multipartProfileFile = await MultipartFile.fromFile(
        field: 'image',
        file: File(profileImagePath!),
        contentType: 'image/jpeg',
      );
    }

    List<MultipartFile> multipartFile = [
      if (coverImagePath?.isNotEmpty ?? false) multipartCoverFile!,
      if (profileImagePath?.isNotEmpty ?? false) multipartProfileFile!,
    ];

    try {
      isLoadingUpdateUserInfo.value = true;
      final response = await _networkCaller.multipart<Map<String, dynamic>>(
        endpoint: role == 'customer'? ApiConstants.customerProfileUpdateUrl : ApiConstants.barberProfileUpdateUrl ,
        fields: fields,
        files: multipartFile.isNotEmpty? multipartFile : null,
        multipartMethodType: MultiPartMethod.patch,
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
        coverImagePath='';
        profileImagePath ='';
        Get.snackbar('Success', response.message ?? 'Successfully updated the profile');
       await fetchProfile();
      } else {
        Get.snackbar('Failed', response.message ?? '');
      }
    } catch (e) {
      print(e);
      throw NetworkException('$e');
    } finally {
      isLoadingUpdateUserInfo.value = false;
    }

  }

  // Example 3: Pick image from gallery
  Future<String> pickImageFromGallery() async {
    File? image = await FilePickerService.pickImageFromGallery();
    if (image != null) {
      print('Image picked: ${image.path}');
      return image.path;
    }
    return '';
  }
}

