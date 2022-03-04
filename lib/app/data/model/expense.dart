import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pfm_app/app/data/enums/enums.dart';
import 'package:pfm_app/app/helpers/helper.dart';

class Expense {
  String? id;
  final String remark;
  DateTime date;
  final String amount;
  final PaymentMode mode;
  final ExpenseCategory category;

  Expense({
    this.id,
    required this.remark,
    required this.date,
    required this.amount,
    required this.mode,
    required this.category,
  });

  final auth = FirebaseAuth.instance;

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      remark: json['remark'],
      date: json['dateTime'].toDate(),
      amount: json['amount'],
      mode: toPaymentMode(json['mode'])!,
      category: parseToExpenseCategory(json['category'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? genRandomId(),
      'userId': auth.currentUser!.uid,
      'remark': remark,
      'amount': amount,
      'dateTime': Timestamp.fromDate(date),
      'mode': mode.value,
      'category': category.value,
    };
  }
}
