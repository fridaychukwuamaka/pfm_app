import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pfm_app/app/controllers/debt_controller.dart';
import 'package:pfm_app/app/data/model/debt.dart';
import 'package:pfm_app/app/views/pages/debts/edit_debt.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService extends GetxService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final onNotifications = BehaviorSubject<String?>();

  showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    flutterLocalNotificationsPlugin
        .show(id, title, body, await _notificationDetails(), payload: payload);
  }
/* 
  Future<void> scheduleReminder(Debt debt, String docPath) async {
    onInit();
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();

    var i = pendingNotificationRequests.indexWhere((element) {
      print(jsonDecode(element.payload!)['debt']);
      print(debt.id);
      return  debt.id != null && jsonDecode(element.payload!)['debt']['id'] == debt.id!;
    });

    await flutterLocalNotificationsPlugin.zonedSchedule(
      i != -1 ? pendingNotificationRequests.length : i,
      'Debt Reminder',
      '${debt.debtorName} debt is due today',
      tz.TZDateTime.now(tz.local)
          .add(debt.payOffBy.difference(DateTime.now()))
          .add(const Duration(minutes: 1)),
      await _notificationDetails(),
      androidAllowWhileIdle: true,
      payload: jsonEncode({
        'docPath': docPath,
        'debt': debt.toSecJson(),
      }),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  } */

  _notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails('1', 'name',
          importance: Importance.high,
          playSound: true,
          icon: '@mipmap/ic_launcher'),
    );
  }

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');
    InitializationSettings initializationSettings =
        const InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (val) async {
        var doc =
            await FirebaseFirestore.instance.collection('debts').doc(val).get();
        var payload = Debt.fromJson(doc.data()!);
        var debtCont = Get.find<DebtController>();
        debtCont.gotoEditDebt(payload, val!);
      },
    );
  }

  @override
  onInit() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Lagos'));
    super.onInit();
  }
}
