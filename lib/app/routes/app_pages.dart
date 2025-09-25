import 'package:get/get.dart';

import '../modules/authentication/bindings/authentication_binding.dart';
import '../modules/authentication/views/barbar_verification_view.dart';
import '../modules/authentication/views/new_password_view.dart';
import '../modules/authentication/views/signin_view.dart';
import '../modules/authentication/views/signup_view.dart';
import '../modules/barber_add_service/bindings/barber_add_service_binding.dart';
import '../modules/barber_add_service/views/barber_add_service_view.dart';
import '../modules/barber_home/bindings/barber_home_binding.dart';
import '../modules/barber_home/views/barber_home_view.dart';
import '../modules/book_appointment/bindings/book_appointment_binding.dart';
import '../modules/book_appointment/views/book_appointment_view.dart';
import '../modules/book_appointment/views/location_selection_map_view.dart';
import '../modules/booking/bindings/booking_binding.dart';
import '../modules/booking/views/booking_view.dart';
import '../modules/booking/views/feedback_view.dart';
import '../modules/booking/views/history_details_view.dart';
import '../modules/booking_management/bindings/booking_management_binding.dart';
import '../modules/booking_management/views/booking_management_view.dart';
import '../modules/customer_profile/bindings/customer_profile_binding.dart';
import '../modules/customer_profile/views/customer_profile_view.dart';
import '../modules/hairdresser_details/bindings/hairdresser_details_binding.dart';
import '../modules/hairdresser_details/views/hairdresser_details_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/onboaring/bindings/onboaring_binding.dart';
import '../modules/onboaring/views/onboaring_view.dart';
import '../modules/onboaring/views/role_selection_view.dart';
import '../modules/search_hairdresser/bindings/search_hairdresser_binding.dart';
import '../modules/search_hairdresser/views/search_hairdresser_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARING,
      page: () => OnboardingView(),
      binding: OnboaringBinding(),
    ),
    GetPage(
      name: _Paths.ROLESELECTION,
      page: () => RoleSelectionView(),
      binding: OnboaringBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignUpView(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => SignInView(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: _Paths.NEWPASSWORD,
      page: () => NewPasswordView(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: _Paths.BARBARVERIFICATION,
      page: () => BarberVerificationView(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: _Paths.HAIRDRESSER_DETAILS,
      page: () => const HairdresserDetailsView(),
      binding: HairdresserDetailsBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_HAIRDRESSER,
      page: () => const SearchHairdresserView(),
      binding: SearchHairdresserBinding(),
    ),
    GetPage(
      name: _Paths.BOOK_APPOINTMENT,
      page: () => const BookAppointmentView(),
      binding: BookAppointmentBinding(),
    ),
    GetPage(
      name: _Paths.LOCATIONSELECTORMAP,
      page: () => const LocationSelectionMapView(),
      binding: BookAppointmentBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING_MANAGEMENT,
      page: () => BookingManagementView(),
      binding: BookingManagementBinding(),
    ),
    GetPage(
        name: _Paths.BOOKING,
        page: () => const BookingView(),
        binding: BookingBinding(),
        transition: Transition.noTransition),
    GetPage(
        name: _Paths.FEEDBACK,
        page: () => const FeedbackView(),
        binding: BookingBinding(),
        transition: Transition.noTransition),
    GetPage(
        name: _Paths.HISTORYDETAILS,
        page: () => const HistoryDetailsView(),
        binding: BookingBinding(),
        transition: Transition.noTransition),
    GetPage(
        name: _Paths.CUSTOMER_PROFILE,
        page: () => const CustomerProfileView(),
        binding: CustomerProfileBinding(),
        transition: Transition.noTransition),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.BARBER_HOME,
      page: () => const BarberHomeView(),
      binding: BarberHomeBinding(),
    ),
    GetPage(
      name: _Paths.BARBER_ADD_SERVICE,
      page: () => const BarberAddServiceView(),
      binding: BarberAddServiceBinding(),
    ),
  ];
}
