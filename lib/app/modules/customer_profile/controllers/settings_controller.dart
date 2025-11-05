
import 'dart:ui';

import 'package:barberita/app/data/api_constants.dart';
import 'package:barberita/app/data/network_caller.dart';
import 'package:barberita/app/modules/customer_profile/model/terms_and_policy_model.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/prefs_helper/prefs_helpers.dart';
import 'package:get/get.dart' hide MultipartFile;


enum TermsAndPolicy  { about,privacy,terms}

class SettingsController extends GetxController {

  final NetworkCaller _networkCaller = NetworkCaller.instance;
  Rx<TermsAndPrivacyModel> termsAndPrivacyModel = TermsAndPrivacyModel().obs;
  var isLoadingTermsPrivacy = false.obs;

  Future<void> fetchTermsPolicy({String? termsPolicy}) async {
    String token = await PrefsHelper.getString('token');

    _networkCaller.clearInterceptors();
    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoadingTermsPrivacy.value = true;
      final response = await _networkCaller.get<Map<String, dynamic>>(
        endpoint:ApiConstants.termsPolicyUrl(termsAndPolicy: termsPolicy),
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
        termsAndPrivacyModel.value = TermsAndPrivacyModel.fromJson( response.data!);
        print(termsAndPrivacyModel.value);

      } else {
        Get.snackbar('Failed', response.message!);
      }
    } catch (e) {
      print(e);
      throw NetworkException('$e');
    } finally {
      isLoadingTermsPrivacy.value = false;
    }

  }


 Future<void> termsPolicyApi(TermsAndPolicy? termsPolicy)async{
    if(termsPolicy != null){
      switch (termsPolicy){
        case TermsAndPolicy.about:
          await fetchTermsPolicy(termsPolicy: 'about');
          break;
        case TermsAndPolicy.privacy:
          await fetchTermsPolicy(termsPolicy: 'privacy');
          break;
        case TermsAndPolicy.terms:
          await fetchTermsPolicy(termsPolicy: 'terms');
          break;
      }
    }

  }

/// ===================  active / deactivate service ===========
  var isLoadingServiceActivation = false.obs;

  Rx<bool> isServiceActive = false.obs;

  Future<void> serviceActivation({VoidCallback? voidCallBack}) async {
    String token = await PrefsHelper.getString('token');

    _networkCaller.clearInterceptors();
    _networkCaller.addRequestInterceptor(ContentTypeInterceptor());
    _networkCaller.addRequestInterceptor(AuthInterceptor(token: token));
    _networkCaller.addResponseInterceptor(LoggingInterceptor());

    try {
      isLoadingServiceActivation.value = true;
      final response = await _networkCaller.patch<Map<String, dynamic>>(
        endpoint:ApiConstants.serviceActivationStatusUrl,
        timeout: Duration(seconds: 10),
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (response.isSuccess && response.data != null) {
        isServiceActive.value = true;
        voidCallBack?.call();
      } else {
        Get.snackbar('Failed', response.message!);
      }
    } catch (e) {
      print(e);
      throw NetworkException('$e');
    } finally {
      isLoadingServiceActivation.value = false;
    }

  }

}

