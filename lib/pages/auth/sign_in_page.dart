import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foxbyte_event/controllers/auth_controller.dart';
import 'package:foxbyte_event/pages/home/home_page.dart';
import 'package:foxbyte_event/services/color_config.dart';
import 'package:foxbyte_event/utils/helper.dart';
import 'package:foxbyte_event/widgets/k_text.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);
  
  final _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/decorations/ornament_login.png',
              fit: BoxFit.cover,
              width: Get.width * 60 / 100,
            ),
            const SizedBox(height: 40),
            KText(
              text: "Foxbyte Event",
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 46),
              child: KText(
                text:
                    "Halo teman Foxbyte, lakukan registrasi peserta yang telah mengunjungi kami pada tiap event yang diadakan.",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                isOverflow: false,
                textAlign: TextAlign.center,
                color: ColorConfig.greyText,
                lineHeight: 1.6,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => _authController.isLoading.value
            ? Container(
                height: 56,
                margin: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                child: Helper.progressBar(),
              )
            : _btnGoogle(),
      ),
    );
  }

  Widget _btnGoogle() {
    return GestureDetector(
      onTap: () {
        _authController.signInWithGoogle().then((user) {
          _authController.user.value = user;
          Get.offAll(() => HomePage());
        });
      },
      child: Container(
        height: 56,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 40),
        decoration: BoxDecoration(
          color: ColorConfig.lightBlueBackground,
          borderRadius: Helper.getRadius(8),
        ),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: Helper.getRadius(8),
                    color: ColorConfig.white,
                  ),
                  child: Image.asset("assets/icons/google_logo.png"),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: ColorConfig.primaryColor,
                  size: 20,
                )
              ],
            ),
            Center(
              child: KText(
                text: "Lanjutkan dengan Google",
                color: ColorConfig.primaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}