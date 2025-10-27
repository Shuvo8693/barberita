import 'package:barberita/app/data/api_constants.dart';
import 'package:barberita/app/data/network_caller.dart';
import 'package:barberita/app/modules/booking_management/model/booking_details_model.dart';

import 'package:barberita/common/prefs_helper/prefs_helpers.dart';
import 'package:get/get.dart';

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
}
