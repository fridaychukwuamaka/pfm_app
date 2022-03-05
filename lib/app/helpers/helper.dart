import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


NumberFormat currencyFormat = NumberFormat.compactSimpleCurrency(name: 'NGN');
NumberFormat currencyFormat1 = NumberFormat.simpleCurrency(name: 'NGN');

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
 String genRandomId() {
  final Random _rnd = Random();
  final code = String.fromCharCodes(Iterable.generate(
      4, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  return code;
}

Future<DateTime?> get showDate async => await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1111),
      lastDate: DateTime(9999),
    );
