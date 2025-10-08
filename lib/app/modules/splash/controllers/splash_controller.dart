import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/jwt_decoder/jwt_decoder.dart';
import 'package:barberita/common/prefs_helper/prefs_helpers.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  navigateTo()async{
   await Future.delayed(Duration(seconds: 3)).then((v)async{
     String token = await PrefsHelper.getString('token');
     final payload = decodeJWT(token);
     print(payload);
    String role = payload['role']??'';
    String phone = payload['phone'];
      Get.toNamed(Routes.ONBOARING);
    });
  }
}
