import 'package:get/get.dart';

import 'package:quitanda/src/pages/base/base_screen.dart';
import 'package:quitanda/src/pages/base/binding/navigation_binding.dart';
import 'package:quitanda/src/pages/home/binding/home_binding.dart';
import 'package:quitanda/src/pages/splash/splash_screen.dart';

import '../auth/view/sign_in_screen.dart';
import '../auth/view/sign_up_screen.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: PagesRoute.splashRoute,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: PagesRoute.signInRoute,
      page: () => SignInScreen(),
    ),
    GetPage(
      name: PagesRoute.signUpRoute,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: PagesRoute.baseRoute,
      page: () => const BaseScreen(),
      bindings: [
        HomeBinding(),
        NavigationBinding(),
      ],
    ),
  ];
}

abstract class PagesRoute {
  static const String signInRoute = '/signin';
  static const String signUpRoute = '/signup';
  static const String splashRoute = '/splash';
  static const String baseRoute = '/';
}
