import 'package:get/get.dart';

import '../modules/authentication/bindings/authentication_binding.dart';
import '../modules/authentication/views/new_password_view.dart';
import '../modules/authentication/views/signin_view.dart';
import '../modules/authentication/views/signup_view.dart';
import '../modules/hairdresser_details/bindings/hairdresser_details_binding.dart';
import '../modules/hairdresser_details/views/hairdresser_details_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
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
      name: _Paths.HAIRDRESSER_DETAILS,
      page: () => const HairdresserDetailsView(),
      binding: HairdresserDetailsBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_HAIRDRESSER,
      page: () => const SearchHairdresserView(),
      binding: SearchHairdresserBinding(),
    ),
  ];
}
