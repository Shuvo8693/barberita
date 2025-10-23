import 'package:barberita/app/data/api_constants.dart';
import 'package:barberita/app/data/network_caller.dart';
import 'package:barberita/app/modules/search_hairdresser/model/nearby_barber_model.dart';
import 'package:barberita/common/prefs_helper/prefs_helpers.dart';
import 'package:get/get.dart';

class SearchHairdresserController extends GetxController {

  final NetworkCaller _networkCaller = NetworkCaller.instance;
  Rx<NearByBarberModel> nearByBarberModel = NearByBarberModel().obs;
  var isLoadingNearByBarber = false.obs;

  Future<void> fetchBarber({String? name, bool? isNearby=false}) async {
    String token = await PrefsHelper.getString('token');

    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoadingNearByBarber.value = true;
      final response = await _networkCaller.get<Map<String, dynamic>>(
        endpoint:ApiConstants.nearbyBarbersUrl(name: name,isNearby: isNearby),
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
        List<dynamic> responseData = response.data!['data'] as List<dynamic>;
        nearByBarberModel.value = NearByBarberModel.fromJson( response.data!);

      } else {
        Get.snackbar('Failed', response.message ?? 'Resend otp failed');
      }
    } catch (e) {
      print(e);
      throw NetworkException('$e');
    } finally {
      isLoadingNearByBarber.value = false;
    }

  }
}
