import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SettingsController extends GetxController {
  var isDarkMode = false.obs; // Default to light mode

  @override
  void onInit() {
    super.onInit();
    // Initialize based on the system theme
    isDarkMode.value = Get.isDarkMode;
  }

  // Toggle theme mode
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
