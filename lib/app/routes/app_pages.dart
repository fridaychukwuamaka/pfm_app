import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:pfm_app/app/bindings/bindings.dart';
import 'package:pfm_app/app/bindings/notification_binding.dart';
import 'package:pfm_app/app/views/pages/authentication/signup.dart';
import 'package:pfm_app/app/views/pages/views.dart';

class AppPages {
  AppPages._();
  static String initial = LoginPage.route;

  static final routes = [
    GetPage(
      name: LoginPage.route,
      page: () => const LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: SignupPage.route,
      page: () => const SignupPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: EditDebtPage.route,
      page: () => const EditDebtPage(),
      binding: DebtBinding(),
    ),
    GetPage(
      name: NotificationPage.route,
      page: () => const NotificationPage(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: HomePage.route,
      page: () => const HomePage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AddExpensePage.route,
      page: () => const AddExpensePage(),
      binding: ExpenseBinding(),
    ),
    GetPage(
      name: EditExpensePage.route,
      page: () => const EditExpensePage(),
      binding: ExpenseBinding(),
    ),
    GetPage(
      name: ExpensePage.route,
      page: () => const ExpensePage(),
      binding: ExpenseBinding(),
    ),
    GetPage(
      name: DebtPage.route,
      page: () => const DebtPage(),
      binding: DebtBinding(),
    ),
    GetPage(
      name: AddDebtPage.route,
      page: () => const AddDebtPage(),
      binding: DebtBinding(),
    ),
  ];
}
