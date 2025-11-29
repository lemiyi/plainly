import 'package:get/get.dart';
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
  ];

}
