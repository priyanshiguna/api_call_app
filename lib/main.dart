import 'package:api_call_app/view/home/new_drop_down_screen.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  //Remove this method to stop OneSignal Debugging
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize("7b066c89-e6e8-430d-8ff0-09b9ec3a704a");
/*
  "\'${jfjfjjfnjfnjfnj}\'"
*/

// The promptForPushNotificationsWithUserResponse function will show tdjdhe iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);
  final id = OneSignal.User.pushSubscription.id;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NewDropDownScreen(),
    );
  }
}
