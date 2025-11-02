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



  Future<void> postReview({VoidCallback? callBack}) async {
    //{'bookingGroupId':bookingGroupId,'myId':myId,'barberId':barberId}
     final bookingGroupId  = Get.arguments['bookingGroupId'] ?? '';
     final myId  = Get.arguments['myId'] ?? '';
     final barberId  = Get.arguments['barberId'] ?? '';
    String token = await PrefsHelper.getString('token');


    final body = {
      "bookingGroupId" : bookingGroupId,
      "customerId" : myId,
      "barberId": barberId,
      "rating" : selectedRating,
      "comment" : commentCtrl.text
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
        callBack?.call();
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
