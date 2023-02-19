import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ServiceLocalNotification {
  static final ServiceLocalNotification _notificationService =
      ServiceLocalNotification._internal();

  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  factory ServiceLocalNotification() {
    return _notificationService;
  }
  ServiceLocalNotification._internal();

  Future<void> setup() async {
    const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSetting = IOSInitializationSettings(requestSoundPermission: true);

    const initSettings =
        InitializationSettings(android: androidSetting, iOS: iosSetting);

    await _localNotificationsPlugin.initialize(initSettings).then((_) {
      debugPrint('setupPlugin: setup success');
    }).catchError((Object error) {
      debugPrint('Error: $error');
    });
  }

  void createLocalNotification(
    String title,
    String body, {
    String channel = 'default',
  }) async {
    final androidDetail = AndroidNotificationDetails(
      channel,
      channel,
      playSound: true,
      importance: Importance.high,
    );

    final noticeDetail = NotificationDetails(android: androidDetail);
    int id = DateTime.now().millisecondsSinceEpoch;
    try {
      await _localNotificationsPlugin.show(id, title, body, noticeDetail);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void cancelAllNotification() {
    _localNotificationsPlugin.cancelAll();
  }
}
