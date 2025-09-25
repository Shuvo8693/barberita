import 'package:get/get.dart';

import '../controllers/barber_home_controller.dart';

class BarberHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BarberHomeController>(
      () => BarberHomeController(),
    );
  }
}
