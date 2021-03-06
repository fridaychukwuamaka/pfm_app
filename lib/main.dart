import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pfm_app/app/data/model/debt.dart';
import 'package:pfm_app/app/data/services/notification_service.dart';
import 'package:pfm_app/app/data/services/permision_service.dart';
import 'package:pfm_app/app/data/services/twillo_service.dart';
import 'package:pfm_app/app/helpers/helper.dart';
import 'package:pfm_app/app/routes/app_pages.dart';
import 'app/themes/themes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> _initFirebase() async {
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

Future<void> _permisions() async {
  await AppPermission.contactPermision();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initFirebase();
  await Hive.initFlutter();
  await GetStorage.init('MyPref');
  await _permisions();
  Hive.registerAdapter(DebtAdapter());
  await Hive.openBox<Debt>('debts');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

listenNotification() {}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((message) async {
      RemoteNotification notification = message.notification!;
      String? payload;
      print(message.data);
      if (message.data.containsKey('debtId')) {
        payload = message.data['debtId'];

        var doc = await FirebaseFirestore.instance
            .collection('debts')
            .doc(payload)
            .get();

        var debt = Debt.fromJson(doc.data()!);

        await Hive.box<Debt>('debts').add(debt);
        var msg =
            'Dear ${debt.debtorName}, \nThis message is to remind you about the ${currencyFormat.format(double.parse(debt.amount))} you borrowed. Please try to pay off this debt today.\nThanks';
        await TwilloService.sendMessage(debt.debtorPhone, msg);
      }

      NotificationService().showNotification(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        payload: payload,
      );
    });

    NotificationService().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppThemes.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
