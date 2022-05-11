import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> onBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (message.data.containsKey('data')) {
    //Handel data message
    final data = message.data['data'];
  }

  if (message.data.containsKey('notification')) {
    //Handel notification message
    final notification = message.data['notification'];
  }
}

class FCM {
  final streamCtrl = StreamController<String>.broadcast();
  final titleCtrl = StreamController<String>.broadcast();
  final bodyCtrl = StreamController<String>.broadcast();

  setNotifications() {
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

    //Handel app is in active state
    forgroundNotification();

    //Handel app is running in background
    backgroundnotification();

    //Handel app is close by user or teminate app
    terminateNotification();
  }

  forgroundNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.data.containsKey('data')) {
        //handel data message
        streamCtrl.sink.add(message.data['data']);
      }
      if (message.data.containsKey('notification')) {
        //Handel Notification message
        streamCtrl.sink.add(message.data['notification']);
      }

      titleCtrl.sink.add(message.notification!.title!);
      bodyCtrl.sink.add(message.notification!.body!);
    });
  }

  backgroundnotification() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data.containsKey('data')) {
        //handel data message
        streamCtrl.sink.add(message.data['data']);
      }
      if (message.data.containsKey('notification')) {
        //Handel Notification message
        streamCtrl.sink.add(message.data['notification']);
      }

      titleCtrl.sink.add(message.notification!.title!);
      bodyCtrl.sink.add(message.notification!.body!);
    });
  }

  terminateNotification() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      if (initialMessage.data.containsKey('data')) {
        //handel data message
        streamCtrl.sink.add(initialMessage.data['data']);
      }
      if (initialMessage.data.containsKey('notification')) {
        //Handel Notification message
        streamCtrl.sink.add(initialMessage.data['notification']);
      }

      titleCtrl.sink.add(initialMessage.notification!.title!);
      bodyCtrl.sink.add(initialMessage.notification!.body!);
    }
  }

  dispose() {
    streamCtrl.close();
    titleCtrl.close();
    bodyCtrl.close();
  }
}
