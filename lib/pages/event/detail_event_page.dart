import 'package:flutter/material.dart';
import 'package:foxbyte_event/models/event.dart';
import 'package:foxbyte_event/services/color_config.dart';
import 'package:foxbyte_event/utils/helper.dart';
import 'package:foxbyte_event/widgets/k_primary_button.dart';
import 'package:foxbyte_event/widgets/k_text.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailEventPage extends StatelessWidget {
  Event event;
  DetailEventPage({Key? key, required this.event}) : super(key: key);

  _openMaps({
    required String lat,
    required String lng,
    String? eventName,
  }) async {
    MapsLauncher.launchCoordinates(
        double.parse(lat), double.parse(lng), eventName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.white,
      appBar: Helper.customAppBar(
        title: "Detail Event",
        bgColor: Colors.white,
        textColor: ColorConfig.blackText,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Container(
              width: Get.width,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Image.network(
                  event.imageUrl,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: KText(
                text: event.name,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                isOverflow: false,
                lineHeight: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: KText(
                text: event.description,
                color: ColorConfig.greyText,
                isOverflow: false,
                lineHeight: 1.6,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: ColorConfig.white,
            boxShadow: Helper.getShadow(
              color: ColorConfig.borderLightGrey,
              blurRadius: 4,
              offset: const Offset(0, -4),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KText(
                text: "Ingin tau lokasinya?",
                fontWeight: FontWeight.w600,
                color: ColorConfig.greyText,
              ),
              KPrimaryButton(
                function: () async {
                  _openMaps(
                    eventName: event.name,
                    lat: event.lat,
                    lng: event.lng,
                  );
                },
                title: "Buka Maps",
                fontsize: 14,
                width: 120,
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
