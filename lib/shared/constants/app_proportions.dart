import 'package:get/get.dart';

class AppProportions {
  static double get screenWidth => Get.width;
  static double get screenHeight => Get.height;
  static double get titleFontSize => screenWidth * 0.08; // 10% of screen width
  static double get subHeadingFontSize =>
      screenWidth * 0.06; // 6% of screen width
  static double get bodyFontSize => screenWidth * 0.045;
  static double get bodyFontSize2 => screenWidth * 0.040;
  // 4.5% of screen width

  static double get padding => screenWidth * 0.04; // 4% of screen width
  static double get verticalSpacing =>
      screenHeight * 0.03; // 3% of screen height
}
