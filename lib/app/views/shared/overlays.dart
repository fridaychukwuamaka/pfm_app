import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfm_app/app/views/shared/shared.dart';

class AppOverlay {
  static void showInfoDialog(
      {required String title,
      String? content,
      Widget? contentReplacement,
      Function()? onPressed,
      String? buttonText}) {
    showDialog(
      context: Get.context!,
      builder: (context) => Material(
        elevation: 10,
        color: Colors.black.withOpacity(0.2),
        child: IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Get.width * 0.8,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Get.textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                    const SizedBox(height: 11),
                    Center(
                      child: contentReplacement ??
                          Text(
                            content ?? "",
                            textAlign: TextAlign.center,
                            style: Get.textTheme.caption!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                    ),
                    const SizedBox(height: 22),
                    SizedBox(
                      width: double.infinity,
                      child: AppButton(
                          title: buttonText ?? "Okay",
                          /*   padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25), */
                          borderRadius: 100,
                          onPressed: onPressed ?? Get.back),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
