import 'package:flutter/material.dart';
import 'package:foxbyte_event/controllers/auth_controller.dart';
import 'package:foxbyte_event/services/color_config.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _authController = Get.put(AuthController());

  @override
  void initState() {
    _authController.checkAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorConfig.white,
      body: Center(
        child: SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(
            color: ColorConfig.primaryColor,
            backgroundColor: Color(0xFFB5EAE6),
          ),
        ),
      ),
    );
  }
}
