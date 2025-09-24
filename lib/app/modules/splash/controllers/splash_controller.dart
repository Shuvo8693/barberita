import 'package:barberita/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  navigateTo()async{
   await Future.delayed(Duration(seconds: 3)).then((v){
      Get.toNamed(Routes.ONBOARING);
    });
  }
}
