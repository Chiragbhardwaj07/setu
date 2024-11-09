import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class BottomNavController extends GetxController {
  var selectedIndex = 2.obs; // Default to 'Home' page (index 2 for FAB)
  final pageController =
      PageController(initialPage: 2); // Home Page is at index 2

  // Function to handle tab selection
  void onTabSelected(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }
}
