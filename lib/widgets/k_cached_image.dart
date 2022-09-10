import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foxbyte_event/services/color_config.dart';
import 'package:get/get.dart';

class KCachedImage extends StatelessWidget {
  double? width;
  double? height;
  double? borderRadius;
  String photoUrl;
  String placeholderPath;

  KCachedImage({
    Key? key,
    this.width,
    this.height,
    this.borderRadius,
    required this.photoUrl,
    required this.placeholderPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius?? 9999)),
      child: SizedBox(
        width: width ?? Get.width,
        height: height,
        child: CachedNetworkImage(
          imageUrl: Uri.parse(photoUrl).toString(),
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, value, loading) {
            return Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  value: loading.progress,
                  backgroundColor: ColorConfig.primaryColor,
                ),
              ),
            );
          },
          errorWidget: (context, error, w) {
            return Image.asset(
              placeholderPath,
              fit: BoxFit.fill,
            );
          },
        ),
      ),
    );
  }
}
