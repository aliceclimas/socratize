import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotService {

  final notificationsPlugin = FlutterLocalNotificationsPlugin();

  final bool _isInitialized = true;

  bool get isInitialized => _isInitialized;

  // INITIALIZE
  Future<void> initNotifications() async {
    if (_isInitialized) return;

    const initSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const initSettings = InitializationSettings(android: initSettingsAndroid);

    await notificationsPlugin.initialize(initSettings);
  }


  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id',
        'Daily Notifications',
        channelDescription: 'Daily Notification Channel',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
  }


  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    return notificationsPlugin.show(
      id,
      title,
      body,
      const NotificationDetails(),
    );
  }
}
