import 'dart:async';
import 'dart:convert';

import 'package:barberita/app/data/api_constants.dart';
import 'package:barberita/app/data/network_caller.dart';
import 'package:barberita/app/modules/booking_management/model/booking_details_model.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/jwt_decoder/payload_value.dart';

import 'package:barberita/common/prefs_helper/prefs_helpers.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BookingManagementController extends GetxController {

  final NetworkCaller _networkCaller = NetworkCaller.instance;
  Rx<BookingDetailsModel> bookingDetailsModel = BookingDetailsModel().obs;
  var isLoadingService = false.obs;

  Future<void> fetchBookingDetails() async {
     String bookingGroupId = Get.arguments['bookingGroupId']??'';
    String token = await PrefsHelper.getString('token');

    _networkCaller.clearInterceptors();
    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoadingService.value = true;
      final response = await _networkCaller.get<Map<String, dynamic>>(
        endpoint:ApiConstants.bookingDetailsUrl(bookingGroupId: bookingGroupId),
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
        bookingDetailsModel.value = BookingDetailsModel.fromJson( response.data!);
        print(bookingDetailsModel.value);

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

  /// ============== mark as done ==================

  var isLoadingMarkAsDone = false.obs;

  Future<void> markAsDone({String? barberId}) async {
    if(isLoadingMarkAsDone.value) return;
    String bookingGroupId = Get.arguments['bookingGroupId'] ?? '';
    String token = await PrefsHelper.getString('token');
    final result = await getPayloadValue();
    String myId = result['userId'];

    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      // 'Accept': '*/*',
      // 'Accept-Encoding': 'gzip, deflate, br',
      // 'Connection': 'keep-alive',
      // 'Cache-Control': 'no-cache',
    };

    try {
      isLoadingMarkAsDone.value = true;

      var request = http.Request('PATCH', Uri.parse(ApiConstants.markAsDoneUrl(bookingGroupId: bookingGroupId)));

      request.headers.addAll(headers);
      request.body = jsonEncode({"status": "mark_as_done"});

      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);

      print('Response status: ${responseBody.statusCode}');
      print('Response body: ${responseBody.body}');

      if (responseBody.statusCode == 200 || responseBody.statusCode == 201) {
        Map<String, dynamic> decodedBody = jsonDecode(responseBody.body);

        Get.toNamed(
          Routes.FEEDBACK,
          arguments: {
            'bookingGroupId': bookingGroupId,
            'myId': myId,
            'barberId': barberId
          },
        );
        Get.snackbar(
          'Successfully',
          decodedBody['message'] ?? 'Mark as done need barber confirmation',
        );
      } else {
        Map<String, dynamic> decodedBody = jsonDecode(responseBody.body);
        Get.snackbar('Failed', decodedBody['message'] ?? 'Request failed');
      }
    } on TimeoutException {
      Get.snackbar('Error', 'Request timeout. Please try again.');
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', '$e');
    } finally {
      isLoadingMarkAsDone.value = false;
    }
  }



/*  Future<void> markAsDone({String? barberId}) async {
     String bookingGroupId = Get.arguments['bookingGroupId']??'';
    String token = await PrefsHelper.getString('token');
     final result = await getPayloadValue();
     String myId = result['userId'];

    _networkCaller.clearInterceptors();
    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoadingMarkAsDone.value = true;
      final response = await _networkCaller.patch<Map<String, dynamic>>(
        endpoint:ApiConstants.markAsDoneUrl(bookingGroupId: bookingGroupId),
        body: {"status" : "mark_as_done"},
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
         Get.toNamed(Routes.FEEDBACK,arguments:{'bookingGroupId':bookingGroupId,'myId':myId,'barberId':barberId});
         Get.snackbar('Successfully', response.message??'Mark as done need barber confirmation');
      } else {
        Get.snackbar('Failed', response.message!);
      }
    } catch (e) {
      print(e);
      throw NetworkException('$e');
    } finally {
      isLoadingMarkAsDone.value = false;
    }

  }*/

}
