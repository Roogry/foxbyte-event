import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foxbyte_event/controllers/auth_controller.dart';
import 'package:foxbyte_event/pages/auth/sign_in_page.dart';
import 'package:foxbyte_event/pages/home/widgets/event_card.dart';
import 'package:foxbyte_event/pages/scanner/qrcode_scan_page.dart';
import 'package:foxbyte_event/services/color_config.dart';
import 'package:foxbyte_event/utils/helper.dart';
import 'package:foxbyte_event/widgets/k_text.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          onPressed: () {
            Get.to(() => const QrcodeScanPage());
          },
          child: SvgPicture.asset(
            "assets/icons/ic_scan.svg",
            width: 32,
            height: 32,
          ),
          backgroundColor: ColorConfig.lightBlueBackground,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: KText(
                  text: "Halo, ${_authController.user.value?.displayName}",
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    KText(
                      text: _authController.user.value?.email?? "test@gmail.com",
                      fontWeight: FontWeight.w600,
                      color: ColorConfig.greyText,
                    ),
                    _btnLogout(onTap: () {
                      Get.offAll(() => SignInPage());
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _cardBanner(
                onTap: () {
                  Get.to(() => const QrcodeScanPage());
                },
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: KText(
                  text: "Riwayat Kunjunganmu",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(spacing: 12, runSpacing: 8, children: [
                  EventCard(),
                  EventCard(),
                  EventCard(),
                  EventCard(),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardBanner({Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: Helper.getRadius(8),
          image: const DecorationImage(
            image: AssetImage("assets/decorations/bg_gradient_spiral.png"),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KText(
                  text: "Ketemu Foxbyte?",
                  color: ColorConfig.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 4),
                KText(
                  text: "Jangan lupa scan barcode",
                  color: ColorConfig.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            const Icon(
              Icons.chevron_right,
              color: ColorConfig.white,
              size: 32,
            )
          ],
        ),
      ),
    );
  }

  Widget _btnLogout({Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: Helper.getRadius(4),
          color: ColorConfig.redLight,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.logout_outlined,
              color: ColorConfig.red,
              size: 12,
            ),
            const SizedBox(width: 4),
            KText(
              text: "Keluar",
              color: ColorConfig.red,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
