import 'package:flutter/material.dart';
import 'package:foxbyte_event/services/color_config.dart';
import 'package:foxbyte_event/utils/helper.dart';
import 'package:foxbyte_event/widgets/k_text.dart';

class KPrimaryButton extends StatefulWidget {
  KPrimaryButton({
    Key? key,
    required this.function,
    this.title,
    this.fontsize,
    this.radius,
    this.height,
    this.width,
    this.bgColor,
    this.fontWeight,
  }) : super(key: key);
  final Function function;
  String? title;
  double? fontsize;
  double? height;
  double? width;
  Color? bgColor;
  FontWeight? fontWeight;
  BorderRadiusGeometry? radius;

  @override
  State<StatefulWidget> createState() {
    return _PrimaryButton();
  }
}

class _PrimaryButton extends State<KPrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.function();
      },
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: widget.radius ?? Helper.getRadius(8)),
          minimumSize:
              Size(widget.width ?? MediaQuery.of(context).size.width, widget.height ?? 50),
          primary: widget.bgColor ?? ColorConfig.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 12)),
      child: KText(
        text: widget.title ?? "Submit",
        color: ColorConfig.white,
        fontSize: widget.fontsize ?? 16,
        fontWeight: widget.fontWeight?? FontWeight.w700,
      ),
    );
  }
}
