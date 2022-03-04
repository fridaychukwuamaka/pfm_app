import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTextStyle {
  AppTextStyle._();
  static const String _font = 'Montserrat';

  static TextStyle bodyText1 = TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontSize: 16 * Get.textScaleFactor * 0.92,
  );
  static TextStyle bodyText2 = TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.normal,
    color: Colors.black,
    fontSize: 15 * Get.textScaleFactor * 0.92,
  );
  static TextStyle subtitle2 = TextStyle(
    fontFamily: _font,
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontSize: 14 * Get.textScaleFactor * 0.92,
  );
  static const TextStyle caption = TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontSize: 12,
  );
  static TextStyle subtitle1 = TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.normal,
    color: Colors.black,
    fontSize: 16 * Get.textScaleFactor * 0.92,
  );
  static  TextStyle headline5 = TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontSize: 20 * Get.textScaleFactor * 0.9,
  );
  static TextStyle headline4 = TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontSize: 18 * Get.textScaleFactor * 0.9,
  );
  static  TextStyle headline6 = TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontSize: 24   * Get.textScaleFactor * 0.9,
  );
  static  TextStyle button = TextStyle(
    fontSize: 18 * Get.textScaleFactor * 0.9,
    fontWeight: FontWeight.w700,
    color: Colors.black,
    fontFamily: _font,
  );
  static  TextStyle headline2 = TextStyle(
    fontSize: 34  * Get.textScaleFactor * 0.9,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontFamily: _font,
  );
}
