import 'package:barberita/app/data/api_constants.dart';
import 'package:barberita/app/data/network_caller.dart';
import 'package:barberita/app/modules/barber_home/model/user_review_model.dart';
import 'package:barberita/common/jwt_decoder/payload_value.dart';

import 'package:barberita/common/prefs_helper/prefs_helpers.dart';
import 'package:get/get.dart';

class BarberAddServiceController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller.instance;
  Rx<UserReviewModel> userReviewModel = UserReviewModel().obs;
  var isLoadingUserReview = false.obs;

  Future<void> fetchUserReview() async {
    String token = await PrefsHelper.getString('token');
    final result = await getPayloadValue();
    final myId = result['userId'];

    _networkCaller.clearInterceptors();
    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoadingUserReview.value = true;
      final response = await _networkCaller.get<Map<String, dynamic>>(
        endpoint:ApiConstants.barberAddedServicesUrl(barberId: myId),
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
