import 'package:barberita/app/data/api_constants.dart';
import 'package:barberita/app/data/network_caller.dart';
import 'package:barberita/app/modules/barber_home/model/user_review_model.dart';

import 'package:barberita/common/prefs_helper/prefs_helpers.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller.instance;
  Rx<UserReviewModel> userReviewModel = UserReviewModel().obs;
  var isLoadingUserReview = false.obs;

  Future<void> fetchNotification() async {
    String token = await PrefsHelper.getString('token');

    _networkCaller.clearInterceptors();
    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoadingUserReview.value = true;
      final response = await _networkCaller.get<Map<String, dynamic>>(
        endpoint:ApiConstants.notificationUrl,
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
        userReviewModel.value = UserReviewModel.fromJson( response.data!);
        print(userReviewModel.value);

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
}
