import 'package:get/get.dart';

import '../controllers/hairdresser_details_controller.dart';

class HairdresserDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HairdresserDetailsController>(
      () => HairdresserDetailsController(),
    );
  }
}
