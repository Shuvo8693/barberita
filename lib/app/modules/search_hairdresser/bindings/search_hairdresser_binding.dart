import 'package:get/get.dart';

import '../controllers/search_hairdresser_controller.dart';

class SearchHairdresserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchHairdresserController>(
      () => SearchHairdresserController(),
    );
  }
}
