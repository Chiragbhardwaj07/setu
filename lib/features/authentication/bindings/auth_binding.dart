import 'package:get/get.dart';
import 'package:vasu/features/authentication/controllers/login_controller.dart';
import 'package:vasu/features/authentication/data/repository/authrepository.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut(() => AuthRepository());
  }
}
