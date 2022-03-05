import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pfm_app/app/controllers/debt_controller.dart';
import 'package:pfm_app/app/helpers/helper.dart';
import 'package:pfm_app/app/helpers/validator.dart';
import 'package:pfm_app/app/views/shared/app_button.dart';
import 'package:pfm_app/app/views/shared/page_input.dart';

import '../../../themes/themes.dart';

class AddDebtPage extends GetView<DebtController> {
  static const route = '/add_debt';
  const AddDebtPage({Key? key}) : super(key: key);

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
          title: const Text('Add Debt'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(AppThemes.appPaddingVal).copyWith(
              top: 40,
            ),
            children: [
              PageInput(
                hint: 'Import from contact',
                label: 'Contact',
                suffix: const Icon(Icons.keyboard_arrow_down),
                readOnly: true, keyboardType: TextInputType.number,
                onTap: () async {
                  Get.bottomSheet(
                    const ContactModal(),
                  );
                },
                // validator: Validator.fullnameValidation,
              ),
              const SizedBox(height: 20),
              PageInput(
                hint: '',
                label: 'Amount (${currencyFormat.currencySymbol})',
                validator: Validator.numberValidation,
                controller: controller.amount,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              PageInput(
                hint: '',
                label: 'Debtor',
                validator: Validator.fullnameValidation,
                controller: controller.name,
              ),
              const SizedBox(height: 20),
              PageInput(
                hint: '',
                label: 'Debtor Phone',
                validator: Validator.phoneNumValidation,
                keyboardType: TextInputType.phone,
                controller: controller.phone,
              ),
              const SizedBox(height: 20),
              PageInput(
                hint: 'Item, Person name etc.',
                label: 'Remark',
                validator: Validator.fullnameValidation,
                controller: controller.remark,
              ),
              const SizedBox(height: 20),
              PageInput(
                hint: '11-03-2020',
                label: 'Date',
                readOnly: true,
                controller: controller.date,
                onTap: () => controller.selectDate(),
              ),
              const SizedBox(height: 20),
              PageInput(
                hint: '11-03-2020',
                label: 'Pay off by',
                readOnly: true,
                controller: controller.payOffBy,
                onTap: () => controller.selectPayOffDate(),
              ),
              const SizedBox(height: 50),
              AppButton(
                title: 'Save',
                onPressed: () => controller.addDebt(_formKey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactModal extends GetView<DebtController> {
  const ContactModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      padding:
          const EdgeInsets.all(AppThemes.appPaddingVal).copyWith(bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          Text(
            'Select Contact',
            style: AppTextStyle.headline5,
          ),
          const SizedBox(height: 15),
          FutureBuilder<List<Contact>>(
            future: ContactsService.getContacts(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Expanded(
                    child: Center(child: Text('Something went wrong')));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                  child: Center(
                    child: LoadingAnimationWidget.newtonCradle(
                      color: AppColors.catalinaBlue,
                      size: 80,
                    ),
                  ),
                );
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final contact = snapshot.data![index];
                    return GestureDetector(
                      onTap: () => controller.selectContact(contact),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: AppColors.catalinaBlue,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 3,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 5),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 13),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      contact.displayName ?? '',
                                      style: AppTextStyle.bodyText2.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      contact.phones!.first.value ?? '',
                                      style: AppTextStyle.bodyText2.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/* class ChooseCategory extends StatelessWidget {
  const ChooseCategory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.all(AppThemes.appPaddingVal),
        children: [
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Choose Category',
            style: AppTextStyle.headline5,
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 15,
            runSpacing: 6,
            children: expenseCategory.values
                .map((e) => ChoiceChip(
                      selectedColor: AppColors.catalinaBlue,
                      disabledColor: const Color.fromARGB(255, 226, 225, 225),
                      label: Text(
                        e.name.toString(),
                      ),
                      selected: false,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
 */
