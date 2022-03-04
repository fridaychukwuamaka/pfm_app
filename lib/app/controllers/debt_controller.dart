import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pfm_app/app/data/model/debt.dart';
import 'package:pfm_app/app/data/repository/debt_repository.dart';
import 'package:pfm_app/app/data/services/api_response.dart';
import 'package:pfm_app/app/data/services/notification_service.dart';
import 'package:pfm_app/app/helpers/helper.dart';
import 'package:pfm_app/app/views/pages/views.dart';
import 'package:pfm_app/app/views/shared/overlays.dart';

class DebtController extends GetxController {
  final DebtRepository _repo;
  DebtController(this._repo);

  final NotificationService _notificationService = NotificationService();

  static Stream<QuerySnapshot> unpaidDebtStream = FirebaseFirestore.instance
      .collection('debts')
      .where('isPaid', isEqualTo: false)
      .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  static Stream<QuerySnapshot> paidDebtStream = FirebaseFirestore.instance
      .collection('debts')
      .where('isPaid', isEqualTo: true)
      .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  static DateFormat timeFormat = DateFormat('dd-MM-y');
  TextEditingController amount = TextEditingController();
  TextEditingController date =
      TextEditingController(text: timeFormat.format(DateTime.now()));
  TextEditingController remark = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController payOffBy = TextEditingController(
    text: timeFormat.format(
      DateTime.now().add(const Duration(days: 1)),
    ),
  );

  RxBool editBtn = false.obs;

  get showEditBtn => editBtn.value = !editBtn.value;

  selectDate() async {
    DateTime? val = await showDate;
    if (val != null) {
      date.text = timeFormat.format(val);
    }
  }

  selectContact(Contact contact) async {
    String? temp;
    name.text = contact.displayName ?? '';

    if (!contact.phones!.first.value!.contains('+234')) {
      temp = contact.phones!.first.value!
          .replaceFirst(RegExp(r'0'), '+234')
          .replaceAll(' ', '')
          .toString();
    }
    phone.text = temp ?? contact.phones!.first.value!.replaceAll(' ', '');
    Get.back();
  }

  selectPayOffDate() async {
    DateTime? val = await showDate;
    if (val != null) {
      payOffBy.text = timeFormat.format(val);
    }
  }

  addDebt(GlobalKey<FormState> form) async {
    if (form.currentState!.validate()) {
      print(_newDebt.toJson());
       ApiResponse response = await _repo.addDebt(_newDebt.toJson());
      /*  await _notificationService.scheduleReminder(
          _newDebt, response.data as String); */
         AppOverlay.showInfoDialog(
        title: response.isSuccessful ? 'Success' : 'Failure',
        content: response.message,
      );
    }
  }

  ediDebt(GlobalKey<FormState> form, String docPath, Debt debt,
      {bool payed = false}) async {
    if (form.currentState!.validate()) {
      var _debt = _newDebt;
      _debt.id = debt.id;
      _debt.isPaid = payed;
      ApiResponse response = await _repo.editDebt(_debt.toJson(), docPath);
      /*  await _notificationService.scheduleReminder(_debt, docPath); */
      AppOverlay.showInfoDialog(
        title: response.isSuccessful ? 'Success' : 'Failure',
        content: response.message,
      );
    }
  }

  gotoEditDebt(Debt debt, String docPath) {
    amount.text = debt.amount;
    remark.text = debt.remark;
    date.text = timeFormat.format(debt.date);
    payOffBy.text = timeFormat.format(debt.payOffBy);
    name.text = debt.debtorName;
    phone.text = debt.debtorPhone;

    Get.toNamed(EditDebtPage.route, arguments: [docPath, debt]);
  }

  Debt get _newDebt => Debt(
        amount: amount.text,
        remark: remark.text,
        date: DateFormat('dd-MM-y').parse(date.text),
        payOffBy: DateFormat('dd-MM-y').parse(payOffBy.text),
        debtorPhone: phone.text,
        debtorName: name.text,
      );

  clearControllers() {
    amount.clear();
    name.clear();
    phone.clear();
    date.clear();
    payOffBy.clear();
    remark.clear();
  }
}
