import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pfm_app/app/data/enums/enums.dart';
import 'package:pfm_app/app/data/model/expense.dart';
import 'package:pfm_app/app/data/repository/expense_repository.dart';
import 'package:pfm_app/app/data/services/api_response.dart';
import 'package:pfm_app/app/helpers/helper.dart';
import 'package:pfm_app/app/views/pages/expense/edit_expense.dart';
import 'package:pfm_app/app/views/shared/shared.dart';

class ExpenseController extends GetxController {
  final ExpenseRepository _repo;
  ExpenseController(this._repo);

  ExpenseCategory category = ExpenseCategory.values.first;
  PaymentMode mode = PaymentMode.values.first;

  static Stream<QuerySnapshot> expenseStream = FirebaseFirestore.instance
      .collection('expenses')
      .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  static DateFormat timeFormat = DateFormat('dd-MM-y');

  TextEditingController amount = TextEditingController();
  TextEditingController remark = TextEditingController();
  TextEditingController date = TextEditingController(
    text: timeFormat.format(DateTime.now()),
  );

  RxBool editBtn = false.obs;

  get showEditBtn => editBtn.value = !editBtn.value;

  onSelectCategory(ExpenseCategory val) {
    category = val;
    update();
  }

  onSelectMode(PaymentMode val) {
    mode = val;
    update();
  }

  selectDate() async {
    DateTime? val = await showDate;
    if (val != null) {
      date.text = timeFormat.format(val);
    }
  }

  addExpense(GlobalKey<FormState> form) async {
    if (form.currentState!.validate()) {
      ApiResponse response = await _repo.addExpense(_newExpense.toJson());
      AppOverlay.showInfoDialog(
        title: response.isSuccessful ? 'Success' : 'Failure',
        content: response.message,
      );
    }
  }

  editExpense(GlobalKey<FormState> form, String docPath, String id) async {
    if (form.currentState!.validate()) {
      var expense = _newExpense;
      expense.id = id;
      expense.date = timeFormat.parse(date.text);
      ApiResponse response =
          await _repo.updateExpense(expense.toJson(), docPath);
      AppOverlay.showInfoDialog(
        title: response.isSuccessful ? 'Success' : 'Failure',
        content: response.message,
      );
    }
  }

  gotoEditExpense(Expense expense, String docPath) {
    amount.text = expense.amount;
    remark.text = expense.remark;
    date.text = timeFormat.format(expense.date);
    category = expense.category;
    mode = expense.mode;
    Get.toNamed(EditExpensePage.route, arguments: [docPath, expense.id]);
  }

  Expense get _newExpense => Expense(
        amount: amount.text,
        remark: remark.text,
        date: DateFormat('dd-MM-y').parse(date.text),
        category: category,
        mode: mode,
      );

  clearControllers() {
    amount.clear();
    remark.clear();
    date.clear();
    mode = PaymentMode.values.first;
    category = ExpenseCategory.values.first;
  }
}
