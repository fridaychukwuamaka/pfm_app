import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:pfm_app/app/themes/themes.dart';




class AppInput extends StatefulWidget {
  const AppInput({
    Key? key,
    this.label,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.isRounded = false,
    this.counterText,
    this.controller,
    this.filledColor,
    this.readOnly = false,
    this.maxLines = 1,
    this.validator,
    this.autovalidateMode,
    this.prefexIcon,
    this.contentPadding = const EdgeInsets.fromLTRB(15, 20, 19, 18),
    this.borderSide = const BorderSide(
      width: 1,
      color: AppColors.oldSilver,
    ),
    this.borderRadius = 8,
    this.initialValue, this.onTap,
  }) : super(key: key);

  final String? label;
  final bool isRounded;
  final String hintText;
  final String? initialValue;
  final String? counterText;
  final bool obscureText;
  final bool readOnly;
  final EdgeInsetsGeometry? contentPadding;
  final Color? filledColor;
  final Widget? suffixIcon;
  final Widget? prefexIcon;
    final Function()? onTap;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final BorderSide borderSide;
  final double borderRadius;
  final TextAlign textAlign;
  final int? maxLength, maxLines;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool obscureText = false;

  @override
  void initState() {
    obscureText = widget.obscureText;
    super.initState();
  }

  void _onObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      
      borderSide: widget.borderSide,
    );

    return TextFormField(
      initialValue: widget.initialValue,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      obscureText: obscureText,
      readOnly: widget.readOnly,
      textAlign: widget.textAlign,
      autovalidateMode: widget.autovalidateMode,
      maxLines: widget.maxLines,
      controller: widget.controller,
      maxLength: widget.maxLength,
      validator: widget.validator,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      style: const TextStyle(
          fontWeight: FontWeight.w500, height: 1, fontSize: 13.5),
      decoration: InputDecoration(
        suffixIcon: widget.obscureText == true
            ? GestureDetector(
                onTap: _onObscureText,
                child: Icon(
                  obscureText ? FeatherIcons.eyeOff : FeatherIcons.eye,
                  size: 19,
                ),
              )
            : widget.suffixIcon,
        prefixIcon: widget.prefexIcon,
        contentPadding: widget.contentPadding,
        hintText: widget.hintText,
        counterText: widget.counterText,
        border: outlineInputBorder,
        fillColor: widget.filledColor,
        filled: widget.filledColor != null ? true : false,
        focusColor: AppColors.silverSand,
        hintStyle: AppTextStyle.bodyText2.copyWith(
          color: const Color(0xFFC4C4C4),
          fontWeight: FontWeight.w500,
        ),

        focusedBorder: widget.borderSide != BorderSide.none
            ? outlineInputBorder.copyWith(
                borderSide: const BorderSide(
                  color: AppColors.catalinaBlue,
                  width: 1.5,
                ),
              )
            : null,
        enabledBorder: outlineInputBorder,
      ),
    );
  }
}
