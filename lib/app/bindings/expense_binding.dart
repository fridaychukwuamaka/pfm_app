import 'package:get/get.dart';
import 'package:pfm_app/app/controllers/expense_controller.dart';
import 'package:pfm_app/app/data/repository/expense_repository.dart';
import 'package:pfm_app/app/data/services/api_helper.dart';

class ExpenseBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<ExpenseController>(() => ExpenseController(
     ExpenseRepository(ApiHelper())));
  }
}