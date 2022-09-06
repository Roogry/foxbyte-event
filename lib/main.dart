import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foxbyte_event/pages/auth/sign_in_page.dart';
import 'package:foxbyte_event/services/color_config.dart';
import 'package:get/route_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Foxbyte Event',
      theme: ThemeData(
        fontFamily: 'SFPro',
        colorScheme: const ColorScheme.light(
          primary: ColorConfig.primaryDarkColor,
          secondary: ColorConfig.primaryColor,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: SignInPage(),
    );
  }
}