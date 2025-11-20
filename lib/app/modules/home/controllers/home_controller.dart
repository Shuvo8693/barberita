import 'package:barberita/app/data/api_constants.dart';
import 'package:barberita/app/data/network_caller.dart';
import 'package:barberita/app/modules/home/model/favourite_model.dart';
import 'package:barberita/app/modules/home/model/top_rated_barber_model.dart';
import 'package:barberita/common/prefs_helper/prefs_helpers.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  final NetworkCaller _networkCaller = NetworkCaller.instance;
  Rx<BarberTopRatedModel> barberTopRatedModel = BarberTopRatedModel().obs;
  var isLoadingTopBarber = false.obs;

  Future<void> fetchTopBarber() async {
    String token = await PrefsHelper.getString('token');

    _networkCaller.clearInterceptors();
    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoadingTopBarber.value = true;
      final response = await _networkCaller.get<Map<String, dynamic>>(
        endpoint:ApiConstants.topRatedBarberUrl,
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
        List<dynamic> responseData = response.data!['data'] as List<dynamic>;
          barberTopRatedModel.value = BarberTopRatedModel.fromJson( response.data!);
          print(barberTopRatedModel.value);

      } else {
        Get.snackbar('Failed', response.message ?? 'Resend otp failed');
      }
    } catch (e) {
      print(e);
      if(!Get.isSnackbarOpen){
        Get.snackbar('Failed to load', e.toString());
      }
      throw NetworkException('$e');
    } finally {
      isLoadingTopBarber.value = false;
    }

  }
/// ======================= fetch favourite =========================

  final Rx<FavoriteBarbersModel> favouriteBarberModel = FavoriteBarbersModel().obs;
  var isLoadingFavouriteBarber = false.obs;
  Future<void> fetchFavouriteBarber() async {
    String token = await PrefsHelper.getString('token');
    _networkCaller.clearInterceptors();
    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoadingFavouriteBarber.value = true;
      final response = await _networkCaller.get<Map<String, dynamic>>(
        endpoint:ApiConstants.favouriteBarberUrl,
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
        List<dynamic> responseData = response.data!['data'] as List<dynamic>;
        favouriteBarberModel.value = FavoriteBarbersModel.fromJson(response.data!);
        print(favouriteBarberModel.value);
      } else {
        // Get.snackbar('Failed', response.message ?? 'Resend otp failed');
      }
    } catch (e) {
      print(e);
      throw NetworkException('$e');
    } finally {
      isLoadingFavouriteBarber.value = false;
    }

  }
}
