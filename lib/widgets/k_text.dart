import 'package:flutter/material.dart';
import 'package:foxbyte_event/services/color_config.dart';

class KText extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? fontSize;
  final String? fontFamily;
  final int? maxLines;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final double? wordSpacing;
  final double? lineHeight;
  final TextDirection? textDirection;
  final TextDecoration? decoration;
  final bool? isOverflow;

  KText({
    required this.text,
    this.color,
    this.fontSize,
    this.fontFamily,
    this.maxLines,
    this.fontWeight,
    this.textAlign,
    this.textDirection,
    this.wordSpacing,
    this.lineHeight,
    this.decoration,
    this.isOverflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text?? "",
      style: TextStyle(
        decoration: decoration,
        fontSize: fontSize?? 14,
        fontFamily: fontFamily,
        fontWeight: fontWeight?? FontWeight.normal,
        color: color?? ColorConfig.blackText,
        wordSpacing: wordSpacing,
        height: lineHeight,
        overflow: isOverflow?? true ? TextOverflow.ellipsis : null,
      ),
      maxLines: maxLines,
      textAlign: textAlign,
      textDirection: textDirection,
    );
  }
}