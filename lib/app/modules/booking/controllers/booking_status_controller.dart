import 'package:barberita/app/data/api_constants.dart';
import 'package:barberita/app/data/network_caller.dart';
import 'package:barberita/app/modules/booking/model/booking_status_model.dart';

import 'package:barberita/common/prefs_helper/prefs_helpers.dart';
import 'package:get/get.dart';

class BookingStatusController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller.instance;
  Rx<BookingsStatusModel> bookingsStatusModel = BookingsStatusModel().obs;
  var isLoadingBookingStatus = false.obs;

  Future<void> fetchBookingStatus({String? bookingStatus}) async {
    String token = await PrefsHelper.getString('token');

    _networkCaller.clearInterceptors();
    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoadingBookingStatus.value = true;
      final response = await _networkCaller.get<Map<String, dynamic>>(
        endpoint:ApiConstants.bookingStatusUrl(status: bookingStatus),
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
        bookingsStatusModel.value = BookingsStatusModel.fromJson( response.data!);
        print(bookingsStatusModel.value);

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
