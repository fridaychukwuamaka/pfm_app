import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfm_app/app/controllers/expense_controller.dart';
import 'package:pfm_app/app/themes/themes.dart';

import '../../data/enums/enums.dart';

class ChooseCategory extends StatelessWidget {
  const ChooseCategory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.all(AppThemes.appPaddingVal),
        children: [
          const SizedBox(
            height: 15,
          ),
          Text(
            'Choose Category',
            style: AppTextStyle.headline5,
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 15,
            children: ExpenseCategory.values
                .map((e) => GetBuilder<ExpenseController>(
                      builder: (_) {
                        return ChoiceChip(
                          selectedColor: AppColors.catalinaBlue,
                          pressElevation: 0,
                          disabledColor:
                              const Color.fromARGB(255, 226, 225, 225),
                          onSelected: (val) => _.onSelectCategory(e),
                          label: Text(
                            e.value,
                            style: AppTextStyle.bodyText2.copyWith(
                              color: _.category == e ? Colors.white : null,
                            ),
                          ),
                          selected: _.category == e,
                        );
                      },
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
