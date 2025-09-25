import 'package:get/get.dart';

import '../controllers/barber_add_service_controller.dart';

class BarberAddServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BarberAddServiceController>(
      () => BarberAddServiceController(),
    );
  }
}
