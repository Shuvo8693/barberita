import 'package:barberita/app/modules/book_appointment/controllers/book_appointment_controller.dart';
import 'package:get/get.dart';



class BookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookAppointmentController>(
      () => BookAppointmentController(),
    );
  }
}
