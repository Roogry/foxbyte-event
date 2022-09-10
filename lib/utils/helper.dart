import 'dart:async';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:foxbyte_event/services/color_config.dart';
import 'package:foxbyte_event/widgets/k_circular_loading.dart';
import 'package:foxbyte_event/widgets/k_text.dart';
import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class Helper {
  late BuildContext context;
  DateTime? currentBackPressTime;
  Helper.of(this.context);

  static getFormatDate(String data, {bool? isNeedTime = true, bool? withDay = false}){
    var value = DateTime.parse(data);
    var date = value.day;
    var month = DateFormat.MMM().format(value);
    var year = value.year;
    var hour = "${value.hour>9 ? value.hour : "0" + value.hour.toString() }:${value.minute > 9 ? value.minute : "0" + value.minute.toString()}";
    var result = "";
    if(isNeedTime == true) {
      result = "$date $month $year, $hour";
    }else{
      result = "$date $month $year";
    }
    if(withDay == true){
      var _dayConvert = DateFormat('EEEE').format(value);
      result = "$_dayConvert $result";
    }
    return result;
  }

  static getFormatTime(String data){
    var value = DateTime.parse(data);
    var hour = "${value.hour>9 ? value.hour : "0" + value.hour.toString() }:${value.minute > 9 ? value.minute : "0" + value.minute.toString()}";
    return hour;
  }

  static List<BoxShadow> getShadow(
      {Color? color,
      BlurStyle? blurStyle,
      double? blurRadius,
      double? spreadRadius,
      Offset? offset}) {
    return [
      BoxShadow(
          color: color ?? ColorConfig.blackText,
          blurRadius: blurRadius ?? 1,
          offset: offset ?? const Offset(1.0, 1.0),
          blurStyle: blurStyle ?? BlurStyle.normal,
          spreadRadius: spreadRadius ?? 1)
    ];
  }

  static BorderRadiusGeometry getRadius(double radius,
      {bool? isAll = true,
      double? radiusTopRight = 0.0,
      double? radiusBottomRight = 0.0,
      double? radiusBottomLeft = 0.0}) {
    return isAll == true
        ? BorderRadius.all(Radius.circular(radius))
        : BorderRadius.only(
            topLeft: Radius.circular(radius),
            bottomLeft: Radius.circular(radiusBottomLeft!),
            bottomRight: Radius.circular(radiusBottomRight!),
            topRight: Radius.circular(radiusTopRight!),
          );
  }

  alertCustomWithAction(content, {Function? function, String? title, String? confirmTitle}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            title: KText(
              text: title?? "Alert",
              textAlign: TextAlign.center,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(content, textAlign: TextAlign.center),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: KText(text: "Batal"),
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            primary: ColorConfig.borderLightGrey,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        ElevatedButton(
                          child: KText(
                            text: confirmTitle ?? "Simpan",
                            color: Colors.white,
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            primary: ColorConfig.primaryColor,
                          ),
                          onPressed: () {
                            function!();
                            // Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }

  alertCustom(content,
      {isBack,
      Function? function,
      title,
      buttonTitle,
      dismissible = true,
      buttonColor}) {
    return showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: Center(
              child: Text(title ?? "Alert"),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(
                    "$content",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    child: Text(
                      buttonTitle ?? "Back",
                      style: const TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      primary: buttonColor ?? ColorConfig.primaryColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (isBack == 1) {
                        Navigator.pop(context);
                      }
                      if (function != null) {
                        function();
                      }
                    },
                  ),
                ],
              ),
            ));
      },
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      // TODO: change with getX toast
      // Fluttertoast.showToast(msg: "Tekan sekali lagi untuk keluar dari aplikasi");
      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
    // SystemNavigator.pop();
    return Future.value(true);
  }

  Widget primaryCircularProgress() {
    return const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(ColorConfig.primaryColor),
    );
  }

  static PreferredSizeWidget customAppBar(
      {Function? function,
      required title,
      Color? bgColor,
      Color? textColor,
      Color? statusBarColor,
      double? elevation,
      bool? canBack}) {
    return AppBar(
      backgroundColor: bgColor ?? ColorConfig.primaryDarkColor,
      elevation: elevation ?? 0.0,
      iconTheme: IconThemeData(color: textColor ?? ColorConfig.white),
      automaticallyImplyLeading: canBack ?? true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
      ),
      toolbarHeight: 68,
      title: KText(
        text: title,
        fontSize: 20,
        color: textColor ?? ColorConfig.white,
        fontWeight: FontWeight.w600,
      ),
      leading: GestureDetector(
        onTap: (() => Get.back()),
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 4, 16),
          decoration: BoxDecoration(
            borderRadius: Helper.getRadius(8),
            border: Border.all(color: const Color(0XFFCCCCCC)),
          ),
          child: Icon(
            Icons.chevron_left,
            color: textColor ?? ColorConfig.white,
            size: 24,
          ),
        ),
      ),
    );
  }

  static progressBar({Color? color}) {
    return Center(
      child: SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
                color ?? ColorConfig.primaryColor)),
      ),
    );
  }

  static OverlayEntry overlayLoader(context) {
    OverlayEntry loader = OverlayEntry(builder: (context) {
      // final size = MediaQuery.of(context).size;
      return Positioned(
          child: Material(
        color: Colors.white54.withOpacity(0.85),
        child: KCircularLoading(height: 200),
      ));
    });
    return loader;
  }

  static hideLoader(OverlayEntry loader, {int? time = 1000}) {
    Timer(Duration(microseconds: time!), () {
      loader.remove();
    });
  }

  lineModal() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        width: MediaQuery.of(context).size.width / 2,
        height: 6,
        decoration: BoxDecoration(
            borderRadius: Helper.getRadius(4, isAll: true),
            color: ColorConfig.grey),
      ),
    );
  }

  static defaultDialog(
      {required BuildContext context,
      required String title,
      List<Widget> children = const <Widget>[]}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: 328,
                  padding: const EdgeInsets.fromLTRB(18, 12, 10, 25),
                  decoration: BoxDecoration(
                    borderRadius: Helper.getRadius(16),
                    color: ColorConfig.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: KText(
                              text: title,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.close,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Column(
                          children: [
                            ...children,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static String getBasePhoneNumber(String number) {
    String subs62 = number.trim().substring(0, 2);
    String subs08 = number.trim().substring(0, 1);
    String result;

    if (subs62.toString().contains("62")) {
      result = number.substring(2, number.length);
    } else if (subs08.toString().contains("0")) {
      result = number.substring(1, number.length);
    } else {
      result = number;
    }

    log(result, name: "Helper(getBasePhoneNumber)");
    return result;
  }

  static launchWA(phone, {required text}) async {
    Uri url = Uri.parse(
        "https://wa.me/+62" + getBasePhoneNumber(phone) + "/?text=" + text);
    try {
      await launchUrl(url);
    } catch (e) {
      print(e);
    }
  }

  static onDevelopmentText() {
    return Center(
      child: KText(text: "Module On Development", fontSize: 16),
    );
  }

  static snackbarSoon() {
    Get.closeAllSnackbars();
    Get.snackbar(
      "Hold On",
      "This module on development",
      icon: const Icon(Icons.warning_rounded, color: ColorConfig.greyText),
      borderRadius: 8,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 40),
      backgroundColor: ColorConfig.white,
    );
  }

  static snackbar({required String title, required String content}) {
    Get.closeAllSnackbars();
    Get.snackbar(
      title,
      content,
      icon: const Icon(Icons.warning_rounded, color: ColorConfig.greyText),
      borderRadius: 8,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 40),
      backgroundColor: ColorConfig.white,
    );
  }
}
