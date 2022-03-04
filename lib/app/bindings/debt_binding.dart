import 'package:get/get.dart';
import 'package:pfm_app/app/controllers/debt_controller.dart';
import 'package:pfm_app/app/data/repository/debt_repository.dart';
import 'package:pfm_app/app/data/services/api_helper.dart';

class DebtBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DebtController>(
      () => DebtController(
        DebtRepository(ApiHelper()),
      ),
    );
  }
}
