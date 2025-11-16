import 'package:barberita/app/data/api_constants.dart';
import 'package:barberita/app/data/network_caller.dart';
import 'package:barberita/app/modules/barber_home/model/user_review_model.dart';
import 'package:barberita/app/modules/notification/model/notification_model.dart';
import 'package:barberita/app/modules/notification/model/unreadAndLatestNotification_model.dart';

import 'package:barberita/common/prefs_helper/prefs_helpers.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller.instance;
  Rx<NotificationModel> notificationModel = NotificationModel().obs;
  var isLoadingNotification = false.obs;


  Future<void> fetchNotification() async {
    String token = await PrefsHelper.getString('token');

    _networkCaller.clearInterceptors();
    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoadingNotification.value = true;
      final response = await _networkCaller.get<Map<String, dynamic>>(
        endpoint:ApiConstants.notificationUrl,
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
        notificationModel.value = NotificationModel.fromJson( response.data!);
        print(notificationModel.value);

      } else {
        Get.snackbar('Failed', response.message!);
      }
    } catch (e) {
      print(e);
      throw NetworkException('$e');
    } finally {
      isLoadingNotification.value = false;
    }
  }
  ///============== fetch badge count =============
  Rx<UnreadAndLatestNotificationModel> unreadAndLatestNotificationModel = UnreadAndLatestNotificationModel().obs;

  Future<void> fetchBadgeCount() async {
    String token = await PrefsHelper.getString('token');

    _networkCaller.clearInterceptors();
    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoadingNotification.value = true;
      final response = await _networkCaller.get<Map<String, dynamic>>(
        endpoint:ApiConstants.badgeCountUrl,
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
        unreadAndLatestNotificationModel.value = UnreadAndLatestNotificationModel.fromJson( response.data!);
        print(unreadAndLatestNotificationModel.value);

      } else {
        Get.snackbar('Failed', response.message!);
      }
    } catch (e) {
      print(e);
      throw NetworkException('$e');
    } finally {
      isLoadingNotification.value = false;
    }
  }

  // @override
  // void onReady() {
  //   super.onReady();
  //  _loadData();
  // }
  //
  // Future<void> _loadData() async {
  //   await fetchNotification();
  // }
}
