import 'package:get/get.dart';
import 'package:pfm_app/app/controllers/auth_controller.dart';
import 'package:pfm_app/app/data/repository/user_repository.dart';
import 'package:pfm_app/app/data/services/api_helper.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(
        UserRepository(ApiHelper()),
      ),
    );
  }
}
