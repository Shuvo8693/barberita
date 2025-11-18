import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/jwt_decoder/jwt_decoder.dart';
import 'package:barberita/common/prefs_helper/prefs_helpers.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  navigateTo()async{
   await Future.delayed(Duration(seconds: 3)).then((v)async{
     String token = await PrefsHelper.getString('token');
     if(token.isEmpty) Get.toNamed(Routes.SIGNIN);
     final payload = decodeJWT(token);
     print(payload);
    String role = payload['role']??'';
    bool isLogIn = payload['isLogin']??false;
    String phone = payload['phone'];
     if(token.isNotEmpty && role == 'customer' && isLogIn){
       Get.toNamed(Routes.HOME);
     }else if(token.isNotEmpty && role == 'barber' && isLogIn){
       Get.toNamed(Routes.BARBER_HOME);
     }else if(token.isNotEmpty && isLogIn==false){
       Get.toNamed(Routes.SIGNIN);
     }else{
       Get.toNamed(Routes.ONBOARING);
     }
    });
  }
}
