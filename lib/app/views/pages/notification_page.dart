import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pfm_app/app/data/model/debt.dart';
import 'package:pfm_app/app/helpers/helper.dart';
import 'package:pfm_app/app/themes/app_colors.dart';
import 'package:pfm_app/app/themes/app_styles.dart';
import 'package:pfm_app/app/themes/app_themes.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  static const route = '/notification_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ValueListenableBuilder<Box<Debt>>(
          valueListenable: Hive.box<Debt>('debts').listenable(),
          builder: (context, box, child) {
            return ListView.builder(
              padding: const EdgeInsets.all(AppThemes.appPaddingVal)
                  .copyWith(top: AppThemes.appPaddingVal * 2),
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                final notificaion = box.values.toList().reversed.toList()[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 25),
                  padding: const EdgeInsets.only(bottom: 25),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppColors.oldSilver),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        FeatherIcons.mail,
                        color:AppColors.oldSilver,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Debt Notification for ${notificaion.debtorName} who borrowed ${currencyFormat.format(int.parse(notificaion.amount))} from you',
                              style: AppTextStyle.bodyText2.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              notificaion.debtorName,
                              style: AppTextStyle.caption,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}
