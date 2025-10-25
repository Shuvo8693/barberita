import 'package:barberita/app/data/api_constants.dart';
import 'package:barberita/app/data/network_caller.dart';
import 'package:barberita/app/modules/hairdresser_details/model/barber_details_model.dart';

import 'package:barberita/common/prefs_helper/prefs_helpers.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {

  final NetworkCaller _networkCaller = NetworkCaller.instance;
  Rx<BarberDetailsModel> barberDetailsModel = BarberDetailsModel().obs;
  var isLoadingBooking = false.obs;

  Future<void> addBooking() async {
    String barberId = Get.arguments['barberId']??'';
    String token = await PrefsHelper.getString('token');

    final body ={
      "serviceIds" :["68d79c7db5f74fc46cdde565" , "68d79c87b5f74fc46cdde571"],
      "barberId" : barberId,
      "date" : "10/10/2025",
      "time" : "10.20am",
      "address" : "demo address dhaka"
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
        barberDetailsModel.value = BarberDetailsModel.fromJson( response.data!);
        print(barberDetailsModel.value);

      } else {
        Get.snackbar('Failed', response.message!);
      }
    } catch (e) {
      print(e);
      throw NetworkException('$e');
    } finally {
      isLoadingBooking.value = false;
    }

  }

}
