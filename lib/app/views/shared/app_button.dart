import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfm_app/app/themes/themes.dart';


class AppButton extends StatefulWidget {
  const AppButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.bckgrndColor = AppColors.catalinaBlue,
    this.textColor = Colors.black,
    this.borderRadius = 8,
    this.border,
    this.width = double.infinity,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
    this.fontSize = 16,
    this.fontColor = Colors.white,
  }) : super(key: key);
  final String title;
  final Function()? onPressed;
  final double borderRadius;
  final Color bckgrndColor;
  final Color textColor;
  final Color fontColor;
  final EdgeInsets padding;
  final double? width;
  final double fontSize;
  final Border? border;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: InkWell(
        onTap: () async {
          setState(() {
            loading = true;
          });
          await widget.onPressed!();
          setState(() {
            loading = false;
          });
        },
        child: Container(
          padding: widget.padding,
          decoration: BoxDecoration(
              color: widget.bckgrndColor,
              border: widget.border,
              borderRadius: BorderRadius.circular(widget.borderRadius)),
          child: Center(
            child: Stack(
              children: [
                Opacity(
                  opacity: loading ? 0 : 1,
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.bodyText1.copyWith(
                      color: widget.fontColor,
                      fontSize: widget.fontSize * Get.textScaleFactor * 0.92,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Opacity(
                      opacity: !loading ? 0 : 1,
                      child: SizedBox.square(
                        dimension: widget.fontSize,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppOutlineButton extends StatefulWidget {
  const AppOutlineButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.borderRadius =8,
    this.border,
    this.width = double.infinity,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
    this.fontSize = 16,
    this.fontColor = AppColors.catalinaBlue,
  }) : super(key: key);
  final String title;
  final Function()? onPressed;
  final double borderRadius;
  final Color fontColor;
  final EdgeInsets padding;
  final double? width;
  final double fontSize;
  final Border? border;

  @override
  State<AppOutlineButton> createState() => _AppOutlineButtonState();
}

class _AppOutlineButtonState extends State<AppOutlineButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        setState(() {
          loading = true;
        });
        await widget.onPressed!();
        setState(() {
          loading = false;
        });
      },
      style: OutlinedButton.styleFrom(
        padding: widget.padding,
        side: const BorderSide(
          width: 1.5,
          color: AppColors.catalinaBlue,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
      ),
      child: Center(
        child: Stack(
          children: [
            Opacity(
              opacity: loading ? 0 : 1,
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: Get.theme.textTheme.bodyText1!.copyWith(
                  color: widget.fontColor,
                  fontSize: widget.fontSize * Get.textScaleFactor * 0.92 ,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Opacity(
                  opacity: !loading ? 0 : 1,
                  child: SizedBox.square(
                    dimension: widget.fontSize,
                    child: CircularProgressIndicator(
                      color: widget.fontColor,
                      strokeWidth: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
