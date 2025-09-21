import 'package:barberita/app/modules/authentication/views/new_password_view.dart';
import 'package:barberita/app/modules/authentication/views/signin_view.dart';
import 'package:get/get.dart';

import '../modules/authentication/bindings/authentication_binding.dart';
import '../modules/authentication/views/signup_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/onboaring/bindings/onboaring_binding.dart';
import '../modules/onboaring/views/onboaring_view.dart';
import '../modules/onboaring/views/role_selection_view.dart';
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
      page: () =>  SignUpView(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () =>  SignInView(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: _Paths.NEWPASSWORD,
      page: () =>  NewPasswordView(),
      binding: AuthenticationBinding(),
    ),
  ];
}
