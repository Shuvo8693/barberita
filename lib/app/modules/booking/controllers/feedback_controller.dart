import 'package:barberita/app/data/api_constants.dart';
import 'package:barberita/app/data/network_caller.dart';

import 'package:barberita/common/prefs_helper/prefs_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackController extends GetxController {

  final NetworkCaller _networkCaller = NetworkCaller.instance;
  int selectedRating = 0;
  final TextEditingController commentCtrl = TextEditingController();
  var isLoadingBookingStatus = false.obs;



  Future<void> postReview() async {
     final result  = Get.arguments ?? '';
    String token = await PrefsHelper.getString('token');


    final body = {
      "bookingGroupId" : "c9131f17-4591-4c24-a826-557180286ab3",
      "customerId" : "68e5fc8c77f9973c84781f8c",
      "barberId": "68d0d3d3d676b78de82f9734",
      "rating" : 5,
      "comment" : "excellent"
    };

    _networkCaller.clearInterceptors();
    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoadingBookingStatus.value = true;
      final response = await _networkCaller.post<Map<String, dynamic>>(
        endpoint:ApiConstants.addReviewUrl,
        body: body,
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {


      } else {
        Get.snackbar('Failed', response.message!);
      }
    } catch (e) {
      print(e);
      throw NetworkException('$e');
    } finally {
      isLoadingBookingStatus.value = false;
    }

  }
}
