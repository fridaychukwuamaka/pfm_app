import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfm_app/app/controllers/auth_controller.dart';
import 'package:pfm_app/app/helpers/validator.dart';
import 'package:pfm_app/app/themes/themes.dart';
import 'package:pfm_app/app/views/shared/shared.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class SignupPage extends GetView<AuthController> {
  const SignupPage({Key? key}) : super(key: key);

  static const route = '/signup_page';

  @override
  Widget build(BuildContext context) {
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
                  'Register',
                  style: AppTextStyle.headline5.copyWith(
                    color: AppColors.catalinaBlue,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Please create an account with us',
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
                   onPressed: () async => await controller.signUp(_formKey),
                  title: 'Signup',
                ),
                const SizedBox(
                  height: 25,
                ),
                Align(
                  child: InkWell(
                     onTap: () => Get.back(),
                    child: Text.rich(
                      const TextSpan(
                        text: 'Already have an account ',
                        children: [
                          TextSpan(
                              text: '? Login',
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
