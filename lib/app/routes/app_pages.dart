import 'package:diamond_app/app/modules/notification/views/notification_detail_view.dart';
import 'package:get/get.dart';

import '../modules/account_receivable/bindings/account_receive_binding.dart';
import '../modules/account_receivable/views/account_receive_view.dart';
import '../modules/auth/forget_password/bindings/forget_password_binding.dart';
import '../modules/auth/forget_password/views/forget_password_view.dart';
import '../modules/auth/login/bindings/login_binding.dart';
import '../modules/auth/login/views/login_view.dart';
import '../modules/auth/verifyotp/bindings/verifyotp_binding.dart';
import '../modules/auth/verifyotp/views/verifyotp_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/root/bindings/root_binding.dart';
import '../modules/root/views/root_view.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/pending_approve/views/pending_approve_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;
  static const MAIN = Routes.MAIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_PASSWORD,
      page: () => const ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.VERIFYOTP,
      page: () => const VerifyOTPView(),
      binding: VerifyotpBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const RootView(),
      binding: RootBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONDETAIL,
      page: () => NotificationDetailView(),
    ),
    GetPage(
      name: _Paths.PENDING_APPROVE,
      page: () => const PendingApproveView(),
    ),
    GetPage(
      name: _Paths.ACCOUNT_RECEIVE,
      page: () => const AccountReceiveView(),
      binding: AccountReceiveBinding(),
    ),
  ];
}
