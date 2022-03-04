import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pfm_app/app/controllers/debt_controller.dart';
import 'package:pfm_app/app/data/model/debt.dart';
import 'package:pfm_app/app/helpers/helper.dart';
import 'package:pfm_app/app/themes/themes.dart';
import 'package:pfm_app/app/views/pages/debts/add_debt.dart';
import 'package:pfm_app/app/views/shared/shared.dart';

class DebtPage extends StatefulWidget {
  static const route = '/debts_page';
  const DebtPage({Key? key}) : super(key: key);

  @override
  State<DebtPage> createState() => _DebtPageState();
}

class _DebtPageState extends State<DebtPage> with TickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 2,
    vsync: this,
  );

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DebtController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debts'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AddDebtPage.route),
        child: const Icon(
          FeatherIcons.plus,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 60,
            padding:
                const EdgeInsets.symmetric(horizontal: AppThemes.appPaddingVal)
                    .copyWith(top: AppThemes.appPaddingVal),
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.catalinaBlue,
              tabs: const [
                Tab(
                  text: 'Unpaid',
                ),
                Tab(
                  text: 'Paid',
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                DebtLists(
                  controller: controller,
                  paid: false,
                ),
                DebtLists(controller: controller),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DebtLists extends StatelessWidget {
  const DebtLists({
    Key? key,
    required this.controller,
    this.paid = true,
  }) : super(key: key);

  final bool paid;
  final DebtController controller;

  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder<QuerySnapshot>(
        stream: paid ? DebtController.paidDebtStream : DebtController.unpaidDebtStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
              ),
            );
          }

          final debts = snapshot.data!.docs;

          return ListView.builder(
            padding:
                const EdgeInsets.all(AppThemes.appPaddingVal).copyWith(top: 35),
            itemCount: debts.length,
            itemBuilder: (context, index) {
              var data = debts[index].data()! as Map<String, dynamic>;
              final debt = Debt.fromJson(data);
              return ItemContainer(
                onPressed: ()=>controller.gotoEditDebt(debt, debts[index].id),
                expense: false,
                id: debt.id!,
                amount:
                    currencyFormat.format(int.parse(debt.amount)),
                other: debt.debtorName,
                date: DateFormat('dd-MM-y').format(debt.date),
                remarks: debt.remark,
              );
            },
          );
        });
  }
}
