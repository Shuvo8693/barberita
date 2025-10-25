import 'package:barberita/app/data/api_constants.dart';
import 'package:barberita/app/data/network_caller.dart';
import 'package:barberita/app/modules/hairdresser_details/model/barber_details_model.dart';
import 'package:barberita/app/modules/hairdresser_details/model/barber_review_model.dart';
import 'package:barberita/app/modules/search_hairdresser/model/nearby_barber_model.dart';
import 'package:barberita/common/prefs_helper/prefs_helpers.dart';
import 'package:get/get.dart';

class HairdresserDetailsController extends GetxController {

  final NetworkCaller _networkCaller = NetworkCaller.instance;
  Rx<BarberDetailsModel> barberDetailsModel = BarberDetailsModel().obs;
  var isLoadingBarberDetails = false.obs;

  Future<void> fetchBarberDetails() async {
    String barberId = Get.arguments['barberId']??'';
    String token = await PrefsHelper.getString('token');

    _networkCaller.clearInterceptors();
    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoadingBarberDetails.value = true;
      final response = await _networkCaller.get<Map<String, dynamic>>(
        endpoint:ApiConstants.barberDetailsUrl(barberId: barberId),
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
        barberDetailsModel.value = BarberDetailsModel.fromJson( response.data!);
        print(barberDetailsModel.value);

      } else {
        Get.snackbar('Failed', response.message ?? 'Resend otp failed');
      }
    } catch (e) {
      print(e);
      throw NetworkException('$e');
    } finally {
      isLoadingBarberDetails.value = false;
    }

  }

 /// ============================ barber review ==========================

  Rx<BarberReviewModel> barberReviewModel = BarberReviewModel().obs;
  var isLoadingBarberReview = false.obs;

  Future<void> fetchBarberReview() async {
    String barberId = Get.arguments['barberId']??'';
    String token = await PrefsHelper.getString('token');

    _networkCaller.clearInterceptors();
    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoadingBarberReview.value = true;
      final response = await _networkCaller.get<Map<String, dynamic>>(
        endpoint:ApiConstants.barberReviewUrl(barberId: barberId),
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
        barberReviewModel.value = BarberReviewModel.fromJson( response.data!);
        print(barberReviewModel.value);

      } else {
        Get.snackbar('Failed', response.message??'');
      }
    } catch (e) {
      print(e);
      throw NetworkException('$e');
    } finally {
      isLoadingBarberReview.value = false;
    }
  }
}
