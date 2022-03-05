import 'package:get/get.dart';

class Validator {
  static String? phoneNumValidation(String? val) {
    if (!GetUtils.isPhoneNumber(val!)) {
      return 'Please enter a valid Phone number';
    }
    return null;
  }

  static String? passwordValidation(String? val) {
    String uppercasePattern = '(?=.*[A-Z])';
    String lowercasePattern = '(?=.*[a-z])';
    String digitPattern = '(?=.*?[0-9])';
    String spcPattern = '(?=.*?[!@#\$&*~])';

    if (!(val!.length >= 8)) {
      return 'Must be at least 8 characters in length';
    } else if (!GetUtils.hasMatch(val, uppercasePattern)) {
      return 'should contain at least one upper case';
    } else if (!GetUtils.hasMatch(val, lowercasePattern)) {
      return 'should contain at least one lower case';
    } else if (!GetUtils.hasMatch(val, digitPattern)) {
      return 'should contain at least one number';
    } else if (!GetUtils.hasMatch(val, spcPattern)) {
      return 'should contain at least one special character';
    } else {
      return null;
    }
  }

  static String? fullnameValidation(String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  static String? emailValidation(String? val) {
    if (!GetUtils.isEmail(val!)) {
      return 'Please enter a valid email';
    }
    return null;
  }
  static String? numberValidation(String? val) {
    if (!GetUtils.isNum(val!)) {
      return 'Please enter a valid number';
    }
    return null;
  }


}
