import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfm_app/app/controllers/expense_controller.dart';
import 'package:pfm_app/app/data/enums/enums.dart';
import 'package:pfm_app/app/helpers/helper.dart';
import 'package:pfm_app/app/helpers/validator.dart';
import 'package:pfm_app/app/themes/app_colors.dart';
import 'package:pfm_app/app/themes/app_styles.dart';
import 'package:pfm_app/app/themes/app_themes.dart';
import 'package:pfm_app/app/views/shared/shared.dart';

class AddExpensePage extends GetView<ExpenseController> {
  static const route = '/add_expense';
  const AddExpensePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return WillPopScope(
       onWillPop: () {
        controller.clearControllers();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Expense'),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppThemes.appPaddingVal).copyWith(
              top: 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                PageInput(
                  hint: '',
                  label: 'Amount (${currencyFormat.currencySymbol})',
                  controller: controller.amount,
                  keyboardType: TextInputType.number,
                  validator: Validator.fullnameValidation,
                ),
                const SizedBox(height: 20),
                PageInput(
                  hint: 'Item, Person name etc.',
                  label: 'Remark',
                  controller: controller.remark,
                  validator: Validator.fullnameValidation,
                ),
                const SizedBox(height: 20),
                GetBuilder<ExpenseController>(
                  builder: (_) {
                    return PageInput(
                      onTap: () {
                        Get.bottomSheet(const ChooseCategory());
                      },
                      readOnly: true,
                      hint: '',
                      initialValue: _.category.value,
                      label: 'Category',
                      suffix: const Icon(Icons.keyboard_arrow_down),
                    );
                  },
                ),
                const SizedBox(height: 20),
                PageInput(
                  hint: '11-03-2020',
                  label: 'Date',
                  controller: controller.date,
                  readOnly: true,
                  onTap: () => controller.selectDate(),
                ),
                const SizedBox(height: 20),
                Text(
                  'Payment Mode',
                  textScaleFactor: 0.92,
                  style: AppTextStyle.bodyText2.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 15,
                  runSpacing: 6,
                  children: PaymentMode.values
                      .map(
                        (e) => GetBuilder<ExpenseController>(
                          builder: (_) {
                            return ChoiceChip(
                              selectedColor: AppColors.catalinaBlue,
                              disabledColor: AppColors.cultured,
                              pressElevation: 0,
                              onSelected: (val) => controller.onSelectMode(e),
                              label: Text(
                                e.value,
                                style: AppTextStyle.bodyText2.copyWith(
                                  color: _.mode == e ? Colors.white : null,
                                ),
                              ),
                              selected: _.mode == e,
                            );
                          },
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 50),
                AppButton(
                  title: 'Save',
                  onPressed: () => controller.addExpense(_formKey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

