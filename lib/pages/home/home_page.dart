import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foxbyte_event/controllers/auth_controller.dart';
import 'package:foxbyte_event/controllers/event_controller.dart';
import 'package:foxbyte_event/pages/auth/sign_in_page.dart';
import 'package:foxbyte_event/pages/home/widgets/event_card.dart';
import 'package:foxbyte_event/pages/scanner/qrcode_scan_page.dart';
import 'package:foxbyte_event/services/color_config.dart';
import 'package:foxbyte_event/utils/helper.dart';
import 'package:foxbyte_event/widgets/k_text.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _authController = Get.put(AuthController());
  final _eventController = Get.put(EventController());

  @override
  void initState() {
    _eventController.getUserVisitedEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String displayName = _authController.user.value?.displayName ?? "Test User";
    String displayEmail = _authController.user.value?.email ?? "test@gmail.com";

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
        child: RefreshIndicator(
          onRefresh: () {
            return _eventController.getUserVisitedEvents();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headerProfile(
                  name: displayName,
                  email: displayEmail,
                  photoUrl: _authController.user.value?.photoURL,
                  context: context,
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
                  child: Obx(() {
                    return _eventController.eventList.value.isNotEmpty ? Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      children: _eventController.eventList.value.map((event) {
                        return EventCard(event: event);
                      }).toList(),
                    ) : _emptyEvent();
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emptyEvent(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 60),
        Image.asset("assets/decorations/empty_illustration.png", height: 100,),
        const SizedBox(height: 20),
        KText(
          text: "Riwayat Kosong",
          fontWeight: FontWeight.w600,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        KText(
          text: "Kunjungi Foxbyte dan scan barcode\nnuntuk meninggalkan jejak kunjunganmu",
          fontSize: 12,
          color: ColorConfig.greyText,
          textAlign: TextAlign.center,
          lineHeight: 1.5,
        ),
      ]
    );
  }

  Widget _headerProfile({
    required String name,
    required String email,
    String? photoUrl,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          photoUrl != null
              ? ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: Image.network(
                    photoUrl,
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                )
              : Container(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KText(
                  text: "Halo, $name",
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: KText(
                        text: email,
                        color: ColorConfig.greyText,
                      ),
                    ),
                    const SizedBox(width: 16),
                    _btnLogout(onTap: () {
                      Helper.of(context).alertCustomWithAction(
                        "Apakah anda yakin akan keluar dari akun ini?",
                        title: "Keluar",
                        confirmTitle: "Yakin",
                        function: () {
                          _authController.signOut();
                          Get.offAll(() => SignInPage());
                        },
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
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
