import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pfm_app/app/helpers/helper.dart';
part 'debt.g.dart';

@HiveType(typeId: 0)
class Debt extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  final String amount;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  DateTime payOffBy;

  @HiveField(4)
  final String debtorPhone;

  @HiveField(5)
  final String debtorName;

  @HiveField(6)
  final String remark;

  @HiveField(7)
  bool isPaid;

  Debt({
    this.id ,
    required this.amount,
    required this.remark,
    this.isPaid = false,
    required this.date,
    required this.payOffBy,
    required this.debtorPhone,
    required this.debtorName,
  });

  final auth = FirebaseAuth.instance;

  factory Debt.fromJson(Map<String, dynamic> json) {
    return Debt(
      id: json['id'],
      remark: json['remark'],
      isPaid: json['isPaid'],
      amount: json['amount'],
      date: json['date'].runtimeType == String
          ? DateTime.parse(json['date'])
          : json['date'].toDate(),
      payOffBy: json['payOffBy'].runtimeType == String
          ? DateTime.parse(json['payOffBy'])
          : json['payOffBy'].toDate(),
      debtorPhone: json['debtorPhone'],
      debtorName: json['debtorName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? genRandomId(),
      'userId': auth.currentUser!.uid,
      'remark': remark,
      'amount': amount,
      'isPaid': isPaid,
      'date': Timestamp.fromDate(date),
      'payOffBy': Timestamp.fromDate(payOffBy),
      'debtorPhone': debtorPhone,
      'debtorName': debtorName,
    };
  }




}
