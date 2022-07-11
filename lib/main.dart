import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_status_saver/src/config/theme.dart';
import 'package:whatsapp_status_saver/src/screens/homepage/screen.homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'WhatsApp Status Saver',
      defaultTransition: Transition.cupertinoDialog,
      // transitionDuration: const Duration(milliseconds: 500),
      theme: themeData,
      
      home: const HomePage(),
    );
  }
}
