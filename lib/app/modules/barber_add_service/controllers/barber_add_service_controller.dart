import 'dart:io';
import 'dart:ui';

import 'package:barberita/app/data/api_constants.dart';
import 'package:barberita/app/data/network_caller.dart';
import 'package:barberita/app/modules/barber_add_service/model/barber_added_service_model.dart';
import 'package:barberita/app/modules/barber_home/model/user_review_model.dart';
import 'package:barberita/app/modules/customer_profile/controllers/customer_profile_controller.dart';
import 'package:barberita/common/jwt_decoder/payload_value.dart';

import 'package:barberita/common/prefs_helper/prefs_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile;

class BarberAddServiceController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller.instance;
  Rx<BarberAddedServiceModel> barberAddedServiceModel = BarberAddedServiceModel().obs;
  var isLoadingUserReview = false.obs;
  final CustomerProfileController _customerProfileController = Get.put(CustomerProfileController());

  Future<void> fetchAddedServices() async {
    String token = await PrefsHelper.getString('token');
    final result = await getPayloadValue();
    final myId = result['userId'];

    _networkCaller.clearInterceptors();
    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoadingUserReview.value = true;
     await _customerProfileController.fetchProfile();
     final userInfoData = _customerProfileController.userInfoModel.value.data;
     String barberId = userInfoData?.barberId??'';
      final response = await _networkCaller.get<Map<String, dynamic>>(
        endpoint:ApiConstants.barberAddedServicesUrl(barberId: barberId ),
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
        barberAddedServiceModel.value = BarberAddedServiceModel.fromJson(response.data!);
        print(barberAddedServiceModel.value);
      } else {
        Get.snackbar('Failed', response.message!);
      }
    } catch (e) {
      print(e);
      throw NetworkException('$e');
    } finally {
      isLoadingUserReview.value = false;
    }
  }

  /// ======================add barber service ===================

  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
   String? serviceImagePath;
  var isLoadingAddService = false.obs;
  Future<void> addBarberServices() async {
    String token = await PrefsHelper.getString('token');
    final result = await getPayloadValue();
    final myId = result['userId'];
   String serviceId = Get.arguments['serviceId']??'';
   bool isEdit = Get.arguments['isEdit']??false;

   print('$serviceId $isEdit');

    _networkCaller.clearInterceptors();
    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    Map<String, String> fields = {
      "serviceName": serviceNameController.text,
      "price": priceController.text,
      "description": descriptionController.text,
    };


    MultipartFile? multipartProfileFile;
    if (serviceImagePath != null && serviceImagePath!.isNotEmpty) {
      multipartProfileFile = await MultipartFile.fromFile(
        field: 'serviceImage',
        file: File(serviceImagePath!),
        contentType: 'image/jpeg',
      );
    }

    List<MultipartFile> multipartFile = [
      if (serviceImagePath?.isNotEmpty ?? false) multipartProfileFile!,
    ];

    try {
      isLoadingAddService.value = true;
      final response = await _networkCaller.multipart<Map<String, dynamic>>(
        endpoint: isEdit ? ApiConstants.updateBarberServiceUrl(serviceId: serviceId) : ApiConstants.addBarberServiceUrl,
        files: serviceImagePath?.isNotEmpty==true ? multipartFile : null,
        fields: fields,
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
        Get.snackbar('Successful', response.message?? ' Successfully added service');
      } else {
        Get.snackbar('Failed', response.message!);
      }
    } catch (e) {
      print(e);
      throw NetworkException('$e');
    } finally {
      isLoadingAddService.value = false;
    }
  }
  /// ==================== toggleBarber individual service status ==========
  var isLoadingServiceToggle = false.obs;
  Future<void> toggleServicesStatus({String? serviceId,VoidCallback? voidCallBack}) async {
    String token = await PrefsHelper.getString('token');
    // final result = await getPayloadValue();
    // final myId = result['userId'];

    _networkCaller.clearInterceptors();
    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoadingServiceToggle.value = true;
      final response = await _networkCaller.patch<Map<String, dynamic>>(
        endpoint:ApiConstants.barberServiceToggleUrl(serviceId: serviceId),
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
        voidCallBack?.call();
      } else {
        Get.snackbar('Failed', response.message!);
      }
    } catch (e) {
      print(e);
      throw NetworkException('$e');
    } finally {
      isLoadingServiceToggle.value = false;
    }
  }

  @override
  void onClose() {
    serviceNameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}

