import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pfm_app/app/data/model/debt.dart';
import 'package:pfm_app/app/data/services/notification_service.dart';
import 'package:pfm_app/app/data/services/permision_service.dart';
import 'package:pfm_app/app/routes/app_pages.dart';
import 'app/controllers/debt_controller.dart';
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
  await GetStorage.init('MyPref');
  await _initFirebase();
  await Hive.initFlutter();
  Hive.registerAdapter(DebtAdapter());
  await Hive.openBox<Debt>('debts');
  await _permisions();
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
      var payload = message.data['debtId'] as String;

      var doc = await FirebaseFirestore.instance
          .collection('debts')
          .doc(payload)
          .get();

      await Hive.box<Debt>('debts').add(Debt.fromJson(doc.data()!));

      // await TwilloService.sendMessage('+2348052141841',  notification.body!);
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
