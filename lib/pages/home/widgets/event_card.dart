import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foxbyte_event/models/event.dart';
import 'package:foxbyte_event/pages/event/detail_event_page.dart';
import 'package:foxbyte_event/services/color_config.dart';
import 'package:foxbyte_event/utils/helper.dart';
import 'package:foxbyte_event/widgets/k_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  Event event;

  EventCard({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(()=> DetailEventPage(event: event,));
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
                event.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 8, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KText(
                    text: Helper.getFormatDate(event.eventDatetime.toDate().toString()),
                    fontSize: 10,
                    color: ColorConfig.greyText,
                  ),
                  const SizedBox(height: 4),
                  KText(
                    text: event.name,
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