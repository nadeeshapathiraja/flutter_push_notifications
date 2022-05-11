import 'package:flutter/material.dart';
import 'package:push_notifications/notification.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String notificationTitle = "No Title";
  String notificationBody = "No Body";
  String notificationData = "No Data";

  @override
  void initState() {
    final firebasemessging = FCM();
    firebasemessging.setNotifications();

    firebasemessging.streamCtrl.stream.listen(_changeData);
    firebasemessging.titleCtrl.stream.listen(_changeTitle);
    firebasemessging.bodyCtrl.stream.listen(_changeBody);

    super.initState();
  }

  _changeData(String msg) => setState(() => notificationData = msg);
  _changeTitle(String msg) => setState(() => notificationTitle = msg);
  _changeBody(String msg) => setState(() => notificationBody = msg);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Flutter Notification Details",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Notification DetailTitle: $notificationTitle",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Notification Body $notificationBody",
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
