import 'package:get/get.dart';
import 'package:planify/features/home/binding/home_binding.dart';
import 'package:planify/features/home/screens/home_screen.dart';
import 'package:planify/features/home/screens/main_screen.dart';
import 'package:planify/features/onboarding/binding/onboarding_binding.dart';
import 'package:planify/features/onboarding/screens/onboarding_screen.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.initial,
      page: () => OnboardingScreen(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => MainScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
  ];

}
