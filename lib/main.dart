import 'package:ecommerce_app/ui/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show AppBar, BuildContext, Center, Colors, Column, ElevatedButton, FloatingActionButton, Icon, Icons, Key, MainAxisAlignment, MaterialApp, Scaffold, State, StatefulWidget, StatelessWidget, Text, Theme, ThemeData, Widget, runApp;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:awesome_notifications/awesome_notifications.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebasePushHandler);
  AwesomeNotifications().initialize(
  null,[
    NotificationChannel(
      channelKey: 'key1',
      channelName: 'E-commerce',
      channelDescription: "Notification example",
      defaultColor: Colors.redAccent,
      ledColor: Colors.cyan,
      playSound: true,
      enableLights: true,
      enableVibration: true
    )
  ]
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter E-Commerce',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashScreen(),
        );
      },
    );
  }
}

Future<void> _firebasePushHandler(RemoteMessage message) async{
  print("Message from push notification is ${message.data}");
  AwesomeNotifications().createNotificationFromJsonData(message.data);
}

