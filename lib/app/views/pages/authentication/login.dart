import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfm_app/app/controllers/auth_controller.dart';
import 'package:pfm_app/app/data/services/biometric_service.dart';
import 'package:pfm_app/app/data/services/my_pref.dart';
import 'package:pfm_app/app/helpers/validator.dart';
import 'package:pfm_app/app/themes/themes.dart';
import 'package:pfm_app/app/views/pages/authentication/signup.dart';
import 'package:pfm_app/app/views/shared/shared.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({Key? key}) : super(key: key);

  static const route = '/login_page';

  @override
  Widget build(BuildContext context) {
    if (MyPref.enableBiometric.val) {
      BiometricService().authenticate();
    }
    final _formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppThemes.appPaddingVal * 1.5),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                Text(
                  'Login',
                  style: AppTextStyle.headline5.copyWith(
                    color: AppColors.catalinaBlue,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Welcome back',
                  style: AppTextStyle.bodyText2.copyWith(
                    color: AppColors.oldSilver,
                  ),
                ),
                const SizedBox(height: 60),
                PageInput(
                  hint: 'Enter your email',
                  label: 'Email or Phone Number',
                  controller: controller.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validator.emailValidation,
                  suffix: const Icon(IconlyLight.message),
                ),
                const SizedBox(
                  height: 42,
                ),
                PageInput(
                  hint: 'Enter your password',
                  label: 'Password',
                  controller: controller.password,
                  validator: Validator.passwordValidation,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                ),
                /* const SizedBox(
                  height: 19,
                ),
                Align(
                  child: GestureDetector(
                    // onTap: () => Get.toNamed(ResetPage.route),
                    child: Text(
                      'Forgot your password ?',
                      style: AppTextStyle.caption.copyWith(
                          color: AppColors.catalinaBlue, fontSize: 13),
                    ),
                  ),
                  alignment: Alignment.topRight,
                ), */
                const SizedBox(
                  height: 50,
                ),
                AppButton(
                  onPressed: () async => await controller.login(_formKey),
                  title: 'Login',
                ),
                const SizedBox(
                  height: 25,
                ),
                Align(
                  child: InkWell(
                    onTap: () => Get.toNamed(SignupPage.route),
                    child: Text.rich(
                      const TextSpan(
                        text: 'Dont have an account ',
                        children: [
                          TextSpan(
                              text: '? Sign Up',
                              style: TextStyle(
                                color: AppColors.amaranthRed,
                              )),
                        ],
                      ),
                      style: AppTextStyle.caption
                          .copyWith(fontWeight: FontWeight.w500, fontSize: 13),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MyPref.enableBiometric.val
                    ? Center(
                        child: IconButton(
                          iconSize: 60,
                          onPressed: () => BiometricService().authenticate(),
                          icon: const Icon(
                            Icons.fingerprint,
                            size: 60,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
