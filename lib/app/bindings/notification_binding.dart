import 'package:get/get.dart';
import 'package:pfm_app/app/controllers/notification_controller.dart';

class NotificationBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<NotificationController>(() => NotificationController());
  }
}