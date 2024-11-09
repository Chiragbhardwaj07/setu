import 'package:get/get.dart';
import 'package:vasu/features/authentication/controllers/language_selection_controller.dart';

class LanguageSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LanguageSelectionController());
  }
}
