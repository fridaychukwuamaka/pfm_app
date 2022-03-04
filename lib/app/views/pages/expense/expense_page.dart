import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pfm_app/app/controllers/expense_controller.dart';
import 'package:pfm_app/app/data/enums/enums.dart';
import 'package:pfm_app/app/data/model/expense.dart';
import 'package:pfm_app/app/helpers/helper.dart';
import 'package:pfm_app/app/themes/themes.dart';
import 'package:pfm_app/app/views/pages/expense/add_expense.dart';
import 'package:pfm_app/app/views/pages/views.dart';
import 'package:pfm_app/app/views/shared/shared.dart';

class ExpensePage extends GetView<ExpenseController> {
  static const route = '/expenses_page';
  const ExpensePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AddExpensePage.route),
        child: const Icon(
          FeatherIcons.plus,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: ExpenseController.expenseStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                ),
              );
            }

            final expenses = snapshot.data!.docs;
            return ListView.builder(
              itemCount: expenses.length,
              padding: const EdgeInsets.all(AppThemes.appPaddingVal)
                  .copyWith(top: 35),
              itemBuilder: (context, index) {
                var data = expenses[index].data()! as Map<String, dynamic>;
                Expense expense = Expense.fromJson(data);
                return ItemContainer(
                  onPressed: () =>
                      controller.gotoEditExpense(expense, expenses[index].id),
                  id: expense.id!,
                  amount: currencyFormat.format(int.parse(expense.amount)),
                  other: expense.category.value,
                  date: DateFormat('dd-MM-y').format(expense.date),
                  remarks: expense.remark,
                );
              },
            );
          }),
    );
  }
}
