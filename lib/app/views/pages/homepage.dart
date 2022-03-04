import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pfm_app/app/controllers/auth_controller.dart';
import 'package:pfm_app/app/controllers/debt_controller.dart';
import 'package:pfm_app/app/controllers/expense_controller.dart';
import 'package:pfm_app/app/data/enums/enums.dart';
import 'package:pfm_app/app/data/model/debt.dart';
import 'package:pfm_app/app/data/model/expense.dart';
import 'package:pfm_app/app/data/model/profile.dart';
import 'package:pfm_app/app/data/repository/debt_repository.dart';
import 'package:pfm_app/app/data/repository/expense_repository.dart';
import 'package:pfm_app/app/data/repository/user_repository.dart';
import 'package:pfm_app/app/data/services/api_helper.dart';
import 'package:pfm_app/app/data/services/my_pref.dart';
import 'package:pfm_app/app/helpers/helper.dart';
import 'package:pfm_app/app/themes/app_colors.dart';
import 'package:pfm_app/app/themes/app_styles.dart';
import 'package:pfm_app/app/themes/app_themes.dart';
import 'package:pfm_app/app/views/pages/views.dart';
import 'package:pfm_app/app/views/shared/item_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const route = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              onTap: () async => Get.toNamed(DebtPage.route),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
              ),
              title: Text(
                'Debt',
                style: AppTextStyle.bodyText1.copyWith(),
              ),
            ),
            ListTile(
              onTap: () async => Get.toNamed(ExpensePage.route),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
              ),
              title: Text(
                'Expense',
                style: AppTextStyle.bodyText1.copyWith(),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: MyPref.storage.listenable,
              builder: (context, value, child) {
                return ListTile(
                  onTap: () {
                    MyPref.enableBiometric.val = !MyPref.enableBiometric.val;
                  },
                  trailing: Transform.scale(
                    scale: 0.6,
                    alignment: Alignment.centerRight,
                    child: CupertinoSwitch(
                      value: MyPref.enableBiometric.val,
                      onChanged: (val) {},
                      activeColor: AppColors.catalinaBlue,
                    ),
                  ),
                  title: Text(
                    'Enable Biometric',
                    style: AppTextStyle.bodyText1.copyWith(),
                  ),
                );
              },
            ),
            GetBuilder<AuthController>(
              init: AuthController(UserRepository(ApiHelper())),
              autoRemove: false,
              builder: (_) {
                return ListTile(
                  onTap: () async => await _.logout(),
                  trailing: const Icon(
                    FeatherIcons.logOut,
                  ),
                  title: Text(
                    'Logout',
                    style: AppTextStyle.bodyText1.copyWith(),
                  ),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(DebtPage.route),
        child: const Icon(
          FeatherIcons.plus,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          const DashBoard(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppThemes.appPaddingVal),
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Debts',
                      style: AppTextStyle.subtitle1.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    InkWell(
                      onTap: () => Get.toNamed(DebtPage.route),
                      child: Text(
                        'More',
                        style: AppTextStyle.caption.copyWith(fontSize: 13),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('debts')
                      .where('isPaid', isEqualTo: false)
                      .where(
                        'userId',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                      )
                      .limit(3)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(child: Text('Something went wrong'));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: LoadingAnimationWidget.prograssiveDots(
                          color: AppColors.catalinaBlue,
                          size: 40,
                        ),
                      );
                    }

                    final debts = snapshot.data!.docs;

                    return GetBuilder<DebtController>(
                      init: DebtController(DebtRepository(ApiHelper())),
                      builder: (_) {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length < 3
                                ? snapshot.data!.docs.length
                                : 3,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var data =
                                  debts[index].data()! as Map<String, dynamic>;
                              final debt = Debt.fromJson(data);
                              return ItemContainer(
                                onPressed: () =>
                                    _.gotoEditDebt(debt, debts[index].id),
                                expense: false,
                                id: debt.id!,
                                amount: currencyFormat
                                    .format(int.parse(debt.amount)),
                                other: debt.debtorName,
                                date: DateFormat('dd-MM-y').format(debt.date),
                                remarks: debt.remark,
                              );
                            });
                      },
                    );
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Expenses',
                      style: AppTextStyle.subtitle1.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    InkWell(
                      onTap: () => Get.toNamed(ExpensePage.route),
                      child: Text(
                        'More',
                        style: AppTextStyle.caption.copyWith(fontSize: 13),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('expenses')
                      .where('userId',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(child: Text('Something went wrong'));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: LoadingAnimationWidget.prograssiveDots(
                          color: AppColors.catalinaBlue,
                          size: 40,
                        ),
                      );
                    }

                    final expenses = snapshot.data!.docs;

                    return GetBuilder<ExpenseController>(
                      init: ExpenseController(ExpenseRepository(ApiHelper())),
                      builder: (_) {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length < 3
                                ? snapshot.data!.docs.length
                                : 3,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var data = expenses[index].data()!
                                  as Map<String, dynamic>;
                              final expense = Expense.fromJson(data);
                              return ItemContainer(
                                onPressed: () => _.gotoEditExpense(
                                    expense, expenses[index].id),
                                id: expense.id!,
                                amount: currencyFormat
                                    .format(int.parse(expense.amount)),
                                other: expense.category.value,
                                date:
                                    DateFormat('dd-MM-y').format(expense.date),
                                remarks: expense.remark,
                              );
                            });
                      },
                    );
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DashBoard extends StatelessWidget {
  const DashBoard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppThemes.appPaddingVal / 2,
          vertical: AppThemes.appPaddingVal / 1.5),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            AppColors.catalinaBlue,
            Color.fromARGB(255, 3, 71, 144),
            Color.fromARGB(255, 2, 19, 37)
          ],
        ),
      ),
      child: SafeArea(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('profile')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              Profile profile = Profile();
              if (snapshot.connectionState == ConnectionState.active) {
                var val = {};
                if (snapshot.data!.exists) {
                  val = snapshot.data!.data() as Map;
                }
                profile = Profile.fromJson(val);
              }
              return Column(
                children: [
                  
                  Row(
                    children: [
                      /*    SvgPicture.asset(
                      'assets/images/menu.svg',
                      width: 21,
                    ), */
                      const SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: /* Text(
                          'Wallet',
                          style: AppTextStyle.bodyText1.copyWith(
                            color: Colors.white,
                          ),
                        ) */
                            const Icon(
                          FeatherIcons.menu,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => Get.toNamed(NotificationPage.route),
                        icon: const Icon(
                          FeatherIcons.bell,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    currencyFormat1.format(profile.expense),
                    style: AppTextStyle.headline6.copyWith(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'Expense',
                    style: AppTextStyle.caption.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            currencyFormat1.format(profile.paidDebt),
                            style: AppTextStyle.subtitle1.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Paid Debt',
                            style: AppTextStyle.caption.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                        child: VerticalDivider(
                          color: Colors.white,
                          thickness: 1.5,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            currencyFormat1.format(profile.unpaidDebt),
                            style: AppTextStyle.subtitle1.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Unpaid Debt',
                            style: AppTextStyle.caption.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              );
            }),
      ),
    );
  }
}
