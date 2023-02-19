import 'dart:io';
import 'package:diamond_app/app/modules/root/controllers/root_controller.dart';
import 'package:diamond_app/app/modules/notification/controllers/notification_controller.dart';
import 'package:diamond_app/utils/service/service_local_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../app/data/provider/storage/storage_token.dart';
import '../values/export.dart';

class ServiceFirebase {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  ServiceFirebase._internal();
  static final instance = ServiceFirebase._internal();
  static String? deviceToken;

  Future<void> initializer() async {
    if (StorageToken.isAccessTokenExist()) {
      await _firebaseMessagingInitalize();
      await _setupNotificationInteractHandler();
    }
  }

  Future<void> _firebaseMessagingInitalize() async {
    _fcm.subscribeToTopic("GLOBAL_NOTIFY");
    await _getDeviceToken();

    if (Platform.isIOS) {
      _fcm.requestPermission(sound: true, badge: false, alert: true);
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: false,
        sound: true,
      );
    }

    if (Platform.isAndroid) {
      ServiceLocalNotification().setup();
      FirebaseMessaging.onMessage.listen(_createLocalNotification);
      FirebaseMessaging.onBackgroundMessage(_createLocalNotification);
    }
  }

  Future<void> _setupNotificationInteractHandler() async {
    await FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? initialMessage) {
      if (initialMessage != null) {
        _routeToNotificationTab(initialMessage);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen(_routeToNotificationTab);
  }

  Future<void> _getDeviceToken() async {
    deviceToken = await _fcm.getToken();
  }

  void _routeToNotificationTab(RemoteMessage message) async {
    await Get.find<NotificationController>().onRetry();
    await Get.find<RootController>().onItemTap(2);
  }

  static Future<void> _createLocalNotification(RemoteMessage message) async {
    var notification = message.data;
    ServiceLocalNotification().createLocalNotification(
      notification['title'] ?? "",
      notification['descriptoin'] ?? "",
    );
  }
}
