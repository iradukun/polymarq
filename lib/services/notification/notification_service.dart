// import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'dart:io';
import 'dart:math';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_push_notifications_pinpoint/amplify_push_notifications_pinpoint.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:polymarq/amplifyconfiguration.dart';



final log = Logger();

class NotificationService {
  static Future<void> configureAmplify() async {
    try {
      final authPlugin = AmplifyAuthCognito();
      final pushPlugin = AmplifyPushNotificationsPinpoint();
      // final analyticsPlugin = AmplifyAnalyticsPinpoint();
      await Amplify.addPlugins([authPlugin, pushPlugin]).then((value) async {
        await Amplify.configure(amplifyconfig);
      });
    } on Exception catch (e) {
      log.e('An error occurred configuring Amplify: $e');
    }
  }

  static Future<void> initialize() async {
    await handlePermissions();
    getDeviceToken();
    await setupInteractMessage();
    final subscription = Amplify
        .Notifications.Push.onNotificationReceivedInForeground
        .listen(handleMessage);

// Remember to cancel the subscription when it is no longer needed
    await subscription.cancel();
  }

  static Future<void> handlePermissions() async {
    final status = await Amplify.Notifications.Push.getPermissionStatus();
    switch (status) {
      case PushNotificationPermissionStatus.granted:
        // no further action is required, user has already granted permissions
        break;
      case PushNotificationPermissionStatus.denied:
        // further attempts to request permissions will no longer do anything
        break;
      case PushNotificationPermissionStatus.shouldRequest:
        // go ahead and request permissions from the user
        await Amplify.Notifications.Push.requestPermissions();
      case PushNotificationPermissionStatus.shouldExplainThenRequest:
        // you should display some explanation to your user before requesting permissions
        await Amplify.Notifications.Push.requestPermissions();
    }
  }

  static String getDeviceToken() {
    var res = '';
    Amplify.Notifications.Push.onTokenReceived.listen((event) {
      res = event;
    }).cancel();
    // //log.d('Device Token: $res');
    return res;
  }

  static Future<void> handleMessage(PushNotificationMessage message) async {
    log.d('handleMessage: ${message.toJson()}');
  }

  //handle tap on notification when app is in background or terminated
  static Future<void> setupInteractMessage() async {
    final launchNotification = Amplify.Notifications.Push.launchNotification;
    if (launchNotification != null) {
      await handleMessage(launchNotification);
    }

    final subscription = 
        Amplify.Notifications.Push.onNotificationOpened.listen(handleMessage);
    await subscription.cancel();

    // when app ins background
  }
}

class NotificationsController {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future<void> initialize() async {
    await FirebaseMessaging.instance.getInitialMessage();
    await requestPermission();
    await getToken();
    FirebaseMessaging.onMessage.listen(messageHandler);
  }

  Future<void> messageHandler(RemoteMessage message) async {
    // final pinpointMessage = PinPointNotification.fromJson(message.data);
    log.d('Message data: ${message.data}');
    final pinpointMessage = message.data;

    FilePathAndroidBitmap? iconBitmap;
    StyleInformation notificationStyle =
        const DefaultStyleInformation(true, true);

    await setupNotificationPlugin();

    const channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    if (pinpointMessage['pinpoint.notification.imageUrl'] != null &&
        (pinpointMessage['pinpoint.notification.imageUrl'] as String)
            .isNotEmpty) {
      final imagePath = await _downloadAndSaveFile(
        pinpointMessage['pinpoint.notification.imageUrl'] as String,
        'bigPicture',
      );

      notificationStyle = BigPictureStyleInformation(
        FilePathAndroidBitmap(imagePath),
        contentTitle:
            '<b>${pinpointMessage['pinpoint.notification.title']}</b>',
        htmlFormatContentTitle: true,
        summaryText: '${pinpointMessage['pinpoint.notification.body']}',
        htmlFormatSummaryText: true,
      );
    }

    if (pinpointMessage['imageIconUrl'] != null &&
        (pinpointMessage['imageIconUrl'] as String).isNotEmpty) {
      final iconPath = await _downloadAndSaveFile(
        pinpointMessage['imageIconUrl'] as String,
        'largeIcon',
      );

      iconBitmap = FilePathAndroidBitmap(iconPath);
    }

    await flutterLocalNotificationsPlugin.show(
      pinpointMessage['id'] as int? ?? Random().nextInt(1000),
      pinpointMessage['pinpoint.notification.title'] as String? ?? 'Polymarq',
      pinpointMessage['pinpoint.notification.body'] as String? ?? 'Polymarq',
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id, // id
          channel.name, // title
          channelDescription: channel.description,
          importance: Importance.high,
          largeIcon: iconBitmap,
          styleInformation: notificationStyle,
        ),
      ),
    );
  }

  Future<void> requestPermission() async {
    final messaging = FirebaseMessaging.instance;

    final settings = await messaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  Future<void> getToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    log.d('Token value: $token');
  }

  Future<void> setupNotificationPlugin() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final response = await http.get(Uri.parse(url));
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }
}
