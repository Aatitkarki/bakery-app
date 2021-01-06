import 'dart:convert';
import 'dart:io';
import 'package:bakery/core/logger/logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final Log log = Log("PushNotificationService");

  Future initialise([String topic]) async {
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showNotification(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _serialiseAndNavigate(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _serialiseAndNavigate(message);
      },
    );

    _fcm.subscribeToTopic("all");
    if (topic != null) {
      log.d("TOPIC: $topic");

      _fcm.subscribeToTopic(topic);
    }

    final token = await _fcm.getToken();
    log.d(token);

    return token;
  }

  unsubscribe(String topic) {
    _fcm.unsubscribeFromTopic(topic);
  }

  void _serialiseAndNavigate(Map<String, dynamic> message) async {
    print("Serialized Message $message");
    var notificationData = message['data'];
    //
    // if (view != null) {
    //   // Navigate to the create post view
    //   if (launch) {
    //     await _goto(view);
    //   } else if (view.toString().contains("://")) {
    //     locator<NavigationService>()
    //         .navigateTo(WebViewPage(url: view, title: "Inapp Browser"));
    //   } else if (view == "home") {
    //     int gotoIndex = 0;
    //
    //     if (tab == "timeline") {
    //       gotoIndex = 0;
    //     } else if (tab == "news") {
    //       gotoIndex = 1;
    //     } else if (tab == "events") {
    //       gotoIndex = 2;
    //     } else if (tab == "resources") {
    //       gotoIndex = 3;
    //     }
    //
    //     locator<NavigationService>()
    //         .navigateTo(HomeView(defaultIndex: gotoIndex), clearStack: true);
    //   } else if (view == "lifehacks") {
    //     locator<NavigationService>().navigateTo(LifeHackView());
    //   } else if (view == "survey") {
    //     locator<NavigationService>().navigateTo(SurveyView());
    //   } else if (view == "statistics") {
    //     locator<NavigationService>().navigateTo(StatisticsByCountryView());
    //   } else if (view == "report") {
    //     locator<NavigationService>().navigateTo(ReportView());
    //   } else if (view == "notice") {
    //     locator<NavigationService>().navigateTo(NoticeView());
    //   } else if (view == "profile") {
    //     locator<NavigationService>().navigateTo(ProfileView());
    //   }
    // If there's no view it'll just open the app on the first view
    // }
  }

  void showNotification(message) async {
    var messageNotification = message['notification'];
    print('Show Notification $messageNotification');
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = new IOSInitializationSettings();

    var initializationSettings = new InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    FlutterLocalNotificationsPlugin().initialize(
      initializationSettings,
      onSelectNotification: (payload) async {
        print("Notification Selected Payload $payload");
        _serialiseAndNavigate(message);
      },
    );

    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      Platform.isAndroid
          ? 'com.latablepastry.customer'
          : 'com.latablepastry.customer',
      'laTablePastryChannel',
      'laTablePastryDescriptionDescription',
      playSound: true,
      icon: "app_icon",
      channelShowBadge: true,
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.high,
      // color: Colors.orangeAccent,
    );

    var iOSPlatformChannelSpecifics = new IOSNotificationDetails(
      presentSound: true,
      presentAlert: true,
      presentBadge: true,
    );

    var platformChannelSpecifics = new NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    try {
      await FlutterLocalNotificationsPlugin().show(
        0,
        messageNotification['title'].toString(),
        messageNotification['body'].toString(),
        platformChannelSpecifics,
        payload: json.encode(messageNotification),
      );
    } catch (e) {
      print(e);
    }
  }
}
