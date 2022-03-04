import 'package:permission_handler/permission_handler.dart';

class AppPermission {
  AppPermission._();

  static Future<void> contactPermision() async {
    var status = await Permission.contacts.status;
    if (!status.isGranted) {
      await Permission.contacts.request();
    }
  }
}
