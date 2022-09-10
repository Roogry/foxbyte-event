import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foxbyte_event/controllers/event_controller.dart';
import 'package:foxbyte_event/pages/home/home_page.dart';
import 'package:foxbyte_event/services/color_config.dart';
import 'package:foxbyte_event/utils/helper.dart';
import 'package:foxbyte_event/widgets/k_text.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrcodeScanPage extends StatefulWidget {
  const QrcodeScanPage({Key? key}) : super(key: key);

  @override
  State<QrcodeScanPage> createState() => _QrcodeScanPageState();
}

class _QrcodeScanPageState extends State<QrcodeScanPage> {
  final _eventController = Get.put(EventController());
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? _result;
  QRViewController? _qrController;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _qrController!.pauseCamera();
    } else if (Platform.isIOS) {
      _qrController!.resumeCamera();
    }
  }

  @override
  void initState() {
    _eventController.eventItem.value = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Rx<bool> isFlashOn = false.obs;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: Get.width,
            height: Get.height,
            child: QRView(
              key: _qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          SizedBox(
            width: Get.width,
            height: Get.height,
            child: Image.asset(
              "assets/overlays/overlay_scanner.png",
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Obx(() {
              return Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buttonAction(
                          onTap: () => Get.back(),
                          buttonSize: 32,
                          child: const Icon(
                            Icons.chevron_left,
                            color: ColorConfig.blackText,
                            size: 16,
                          ),
                        ),
                        _buttonAction(
                          onTap: () async {
                            await _qrController?.toggleFlash();
                            isFlashOn.value = !isFlashOn.value;
                          },
                          buttonSize: 32,
                          child: Icon(
                            isFlashOn.value
                                ? Icons.flash_on_rounded
                                : Icons.flash_off_rounded,
                            color: ColorConfig.blackText,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                    _eventController.isLoading.value
                        ? _progressQrcode()
                        : Container(),
                  ],
                ),
              );
            }),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Column(
                children: [
                  KText(
                    text:
                        "Arahkan kameramu ke seluruh\nkode QR untuk mulai scan",
                    color: ColorConfig.white.withOpacity(.8),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  _buttonAction(
                    onTap: () => Get.back(),
                    buttonSize: 60,
                    child: const Icon(
                      Icons.close,
                      color: ColorConfig.blackText,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonAction({
    required Function() onTap,
    required double buttonSize,
    required Widget child,
  }){
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        onPrimary: Colors.grey,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: Size(buttonSize, buttonSize),
      ),
      child: child,
    );
  }

  Widget _progressQrcode() {
    return Column(
      children: [
        const SizedBox(height: 40),
        Helper.progressBar(color: ColorConfig.white),
        const SizedBox(height: 20),
        KText(
          text: "Mengolah data qrcode..",
          textAlign: TextAlign.center,
          color: Colors.white.withOpacity(.8),
        ),
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    _qrController = controller;
    _qrController!.resumeCamera();

    controller.scannedDataStream.listen((scanData) {
      _result = scanData;

      if (_result?.code != "" && !_eventController.isLoading.value) {
        _eventController.getEventByQr(qrcode: _result!.code!).then((event) async {
          if (event != null) {
            await controller.pauseCamera();
            Get.offAll(() => const HomePage());
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _qrController?.dispose();
    super.dispose();
  }
}
