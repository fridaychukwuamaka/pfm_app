import 'package:flutter/material.dart';
import 'package:pfm_app/app/themes/themes.dart';
import 'package:pfm_app/app/views/shared/shared.dart';

class PageInput extends StatelessWidget {
  const PageInput({
    Key? key,
    required this.hint,
    required this.label,
    this.prefix,
    this.suffix,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.autovalidateMode,
    this.onTap, this.readOnly = false, this.initialValue,
  }) : super(key: key);

  final String hint;
  final String label;
  final String? initialValue;
  final Widget? prefix;
  final TextInputType keyboardType;
  final AutovalidateMode? autovalidateMode;
  final bool readOnly;
  final Widget? suffix;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          textScaleFactor: 0.92,
          style: AppTextStyle.bodyText2.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        AppInput(
          onTap: onTap,
          readOnly: readOnly,
          hintText: hint,
          keyboardType: keyboardType,
          controller: controller,
          validator: validator,
          autovalidateMode: autovalidateMode,
          obscureText: obscureText,
          initialValue: initialValue,
          //  contentPadding: const EdgeInsets.only(top: 13),
          prefexIcon: prefix,
          suffixIcon: suffix,
        ),
      ],
    );
  }
}
