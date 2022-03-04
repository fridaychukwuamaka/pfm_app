import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:pfm_app/app/controllers/debt_controller.dart';
import 'package:pfm_app/app/data/model/debt.dart';
import 'package:pfm_app/app/helpers/helper.dart';
import 'package:pfm_app/app/helpers/validator.dart';
import 'package:pfm_app/app/themes/app_themes.dart';
import 'package:pfm_app/app/views/shared/app_button.dart';
import 'package:pfm_app/app/views/shared/page_input.dart';

class EditDebtPage extends GetView<DebtController> {
  const EditDebtPage({Key? key}) : super(key: key);
  static const route = '/edt_debt_page';

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final docPath = Get.arguments[0] as String;
    final debt = Get.arguments[1] as Debt;
    controller.editBtn = false.obs;
    return WillPopScope(
       onWillPop: () {
        controller.clearControllers();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Debt'),
          actions: [
            IconButton(
              onPressed: () => controller.showEditBtn,
              icon: const Icon(FeatherIcons.edit),
            ),
            const SizedBox(width: 6),
          ],
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppThemes.appPaddingVal).copyWith(
              top: 40,
            ),
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PageInput(
                    hint: '',
                    label: 'Amount (${currencyFormat.currencySymbol})',
                    validator: Validator.fullnameValidation,
                    controller: controller.amount,
                    keyboardType: TextInputType.number,
                    readOnly: !controller.editBtn.value,
                  ),
                  const SizedBox(height: 20),
                  PageInput(
                    hint: '',
                    label: 'Debtor',
                    validator: Validator.fullnameValidation,
                    controller: controller.name,
                    readOnly: !controller.editBtn.value,
                  ),
                  const SizedBox(height: 20),
                  PageInput(
                    hint: '',
                    label: 'Debtor Phone',
                    validator: Validator.phoneNumValidation,
                    keyboardType: TextInputType.phone,
                    controller: controller.phone,
                    readOnly: !controller.editBtn.value,
                  ),
                  const SizedBox(height: 20),
                  PageInput(
                    hint: 'Item, Person name etc.',
                    label: 'Remark',
                    validator: Validator.fullnameValidation,
                    controller: controller.remark,
                    readOnly: !controller.editBtn.value,
                  ),
                  const SizedBox(height: 20),
                  PageInput(
                    hint: '11-03-2020',
                    label: 'Date',
                    controller: controller.date,
                    onTap: () => controller.selectDate(),
                    readOnly: true,
                  ),
                  const SizedBox(height: 20),
                  PageInput(
                    hint: '11-03-2020',
                    label: 'Pay off by',
                    controller: controller.payOffBy,
                    onTap: () => controller.selectPayOffDate(),
                    readOnly: true,
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      !debt.isPaid
                          ? Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: AppButton(
                                      title: 'Paid',
                                      onPressed: () => controller.ediDebt(
                                          _formKey, docPath, debt,
                                          payed: true),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                      Obx(
                        () => controller.editBtn.isTrue && !debt.isPaid
                            ? const SizedBox(width: 15)
                            :const SizedBox.shrink(),
                      ),
                      Obx(
                        () => controller.editBtn.isTrue
                            ? Expanded(
                                child: AppOutlineButton(
                                  title: 'Save',
                                  onPressed: () =>
                                      controller.ediDebt(_formKey, docPath, debt, payed: debt.isPaid),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
