import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vasu/features/authentication/bindings/auth_binding.dart';
import 'package:vasu/features/authentication/bindings/language_selection_binding.dart';
import 'package:vasu/features/authentication/bindings/onboarding_binding.dart';
import 'package:vasu/features/authentication/views/language_selection.dart';
import 'package:vasu/features/authentication/views/login/login_screen.dart';
import 'package:vasu/features/authentication/views/onboarding_screen.dart';
import 'package:vasu/features/authentication/views/otp_screen.dart';

class AppPages {
  static const initial = Routes.login;

  static final routes = [
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.otp,
      page: () => OTPScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.onboarding,
      page: () => OnboardingScreen(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: Routes.language_selection,
      page: () => LanguageSelectionScreen(),
      binding: LanguageSelectionBinding(),
    ),
  ];
}

class Routes {
  static const login = '/login';
  static const otp = '/otp/:phoneNumber';
  static const onboarding = '/onboarding';
  static const language_selection = '/language';
}
