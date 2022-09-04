import 'package:flutter/material.dart';
import 'package:foxbyte_event/pages/event/detail_event_page.dart';
import 'package:foxbyte_event/services/color_config.dart';
import 'package:foxbyte_event/utils/helper.dart';
import 'package:foxbyte_event/widgets/k_text.dart';
import 'package:get/get.dart';

class EventCard extends StatelessWidget {
  const EventCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(()=> const DetailEventPage());
      },
      child: Container(
        width: Get.width * 5 / 10 - 24,
        decoration: BoxDecoration(
          borderRadius: Helper.getRadius(12),
          color: ColorConfig.white,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8)),
              child: Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhGXhwIa1o8HpGbvO3aR-PBV9ME4o4wWd9Vw&usqp=CAU",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 8, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KText(
                    text: "15 Juli 2022, 10:00 am",
                    fontSize: 10,
                    color: ColorConfig.greyText,
                  ),
                  const SizedBox(height: 4),
                  KText(
                    text:
                        "TRANSFORMAKING: Roadshow Bali FAB Fest 2022",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}