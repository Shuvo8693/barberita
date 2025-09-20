import 'package:get/get.dart';

import '../controllers/onboaring_controller.dart';

class OnboaringBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboaringController>(
      () => OnboaringController(),
    );
  }
}
