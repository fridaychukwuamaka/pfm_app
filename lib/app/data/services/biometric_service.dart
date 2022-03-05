import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pfm_app/app/views/pages/homepage.dart';

class BiometricService extends GetxService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
    }
    return canCheckBiometrics;
  }

  Future<void> authenticate() async {
    if (await _checkBiometrics()) {
    
      try {
        var val = await _auth.authenticate(
          localizedReason: ' ',
          useErrorDialogs: true,
          androidAuthStrings: const AndroidAuthMessages(
            biometricHint: '',
            signInTitle: 'Sign In',
          ),
          stickyAuth: true,
        );
        if (val) {
          Get.offAllNamed(HomePage.route);
        }
      } on PlatformException catch (e) {
      }
    }
  }
}
