import 'package:barberita/app/data/api_constants.dart';
import 'package:barberita/app/data/network_caller.dart';
import 'package:barberita/app/modules/hairdresser_details/model/barber_details_model.dart';
import 'package:barberita/app/modules/hairdresser_details/model/service_model.dart';
import 'package:barberita/app/routes/app_pages.dart';

import 'package:barberita/common/prefs_helper/prefs_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class BookingController extends GetxController {

  final NetworkCaller _networkCaller = NetworkCaller.instance;
  Rx<BarberServicesModel> barberServiceModel = BarberServicesModel().obs;
  var isLoadingService = false.obs;

  Future<void> fetchService() async {
    String barberId = Get.arguments['barberId']??'';
    await PrefsHelper.setString('barberId',barberId);
    String token = await PrefsHelper.getString('token');

    _networkCaller.clearInterceptors();
    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoadingService.value = true;
      serviceIdList = [];
      final response = await _networkCaller.get<Map<String, dynamic>>(
        endpoint:ApiConstants.barberServiceUrl(barberId: barberId),
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
        barberServiceModel.value = BarberServicesModel.fromJson( response.data!);
        print(barberServiceModel.value);

      } else {
        Get.snackbar('Failed', response.message!);
      }
    } catch (e) {
      print(e);
      throw NetworkException('$e');
    } finally {
      isLoadingService.value = false;
    }

  }
  /// ================= For book appointment view page ===============
 /// ===================== add booking =============================

  LatLng? currentLocation;
  String? selectedAddress;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  List<String> serviceIdList = [];

  var isLoadingBooking = false.obs;

  Future<void> addBooking() async {
    String token = await PrefsHelper.getString('token');
    String barberId = await PrefsHelper.getString('barberId');

    final date  = DateFormat('dd-MM-yyyy').format(selectedDate!);


    final body ={
      "serviceIds" :serviceIdList,
      "barberId" : barberId,
      "date" : date,
      "time" : "${selectedTime?.hour} : ${selectedTime?.minute} ${selectedTime?.period==DayPeriod.am?'AM':'PM'}",
      "address" : selectedAddress
    };

    _networkCaller.clearInterceptors();
    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoadingBooking.value = true;
      final response = await _networkCaller.post<Map<String, dynamic>>(
        endpoint:ApiConstants.addBookingUrl,
        body: body,
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
       List<dynamic> bookingData = response.data?['data'] as List<dynamic>;
        String bookingGroupId = bookingData.first['bookingGroupId']??'';
        Get.toNamed(Routes.BOOKING_MANAGEMENT,arguments: {'bookingGroupId':bookingGroupId});
        Get.snackbar('Success', response.message ?? 'Booking created successfully');
      } else {
        Get.snackbar('Failed', response.message ?? '');
      }
    } catch (e) {
      print(e);
      throw NetworkException('$e');
    } finally {
      isLoadingBooking.value = false;
    }

  }

 /// ================= fetch book info fro book appointment view page ===============
  Future<void> fetchBookedInfo() async {
    String barberId = Get.arguments['barberId']??'';
    String token = await PrefsHelper.getString('token');

    _networkCaller.clearInterceptors();
    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoadingService.value = true;
      serviceIdList = [];
      final response = await _networkCaller.get<Map<String, dynamic>>(
        endpoint:ApiConstants.bookedServiceInfoUrl(barberId: barberId),
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
        barberServiceModel.value = BarberServicesModel.fromJson( response.data!);
        print(barberServiceModel.value);

      } else {
        Get.snackbar('Failed', response.message!);
      }
    } catch (e) {
      print(e);
      throw NetworkException('$e');
    } finally {
      isLoadingService.value = false;
    }

  }

}
