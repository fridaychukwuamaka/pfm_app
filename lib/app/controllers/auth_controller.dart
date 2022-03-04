import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfm_app/app/data/repository/user_repository.dart';
import 'package:pfm_app/app/data/services/api_response.dart';
import 'package:pfm_app/app/data/services/my_pref.dart';
import 'package:pfm_app/app/views/pages/authentication/login.dart';
import 'package:pfm_app/app/views/pages/homepage.dart';
import 'package:pfm_app/app/views/shared/shared.dart';

class AuthController extends GetxController {
  final UserRepository _repo;
  AuthController(this._repo);

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signUp(GlobalKey<FormState> form) async {
    if (form.currentState!.validate()) {
      ApiResponse response = await _repo.register(_payload);
      if (response.isSuccessful) {
        ApiResponse response = await _repo.login(_payload);
        if (response.isSuccessful) {
          Get.offNamed(HomePage.route);
          return;
        }
      }
      AppOverlay.showInfoDialog(
        title: 'Failure',
        content: response.message,
      );
    }
  }

  login(GlobalKey<FormState> form) async {
    if (form.currentState!.validate()) {
      ApiResponse response = await _repo.login(_payload);
      if (response.isSuccessful) {
        Get.offNamed(HomePage.route);
      } else {
        AppOverlay.showInfoDialog(
          title: 'Failure',
          content: response.message,
        );
      }
    }
  }

  Future<void> logout() async {
    await _repo.logout();
    Get.offNamed(LoginPage.route);
    MyPref.clearBoxes();
  }

  Map<String, dynamic> get _payload => {
        'email': email.text,
        'password': password.text,
      };
}
