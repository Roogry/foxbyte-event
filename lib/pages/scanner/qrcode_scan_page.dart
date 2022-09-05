import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foxbyte_event/services/color_config.dart';
import 'package:foxbyte_event/widgets/k_text.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrcodeScanPage extends StatefulWidget {
  const QrcodeScanPage({Key? key}) : super(key: key);

  @override
  State<QrcodeScanPage> createState() => _QrcodeScanPageState();
}

class _QrcodeScanPageState extends State<QrcodeScanPage> {
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
  Widget build(BuildContext context) {
    Rx<bool> _isFlashOn = false.obs;

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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: (() => Get.back()),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.grey,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(32, 32),
                    ),
                    child: const Icon(
                      Icons.chevron_left,
                      color: ColorConfig.blackText,
                      size: 16,
                    ),
                  ),
                  Obx(() {
                    return ElevatedButton(
                      onPressed: () async {
                        await _qrController?.toggleFlash();
                        _isFlashOn.value = !_isFlashOn.value;
                        print(_isFlashOn.value.toString());
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.grey,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: const Size(32, 32),
                      ),
                      child: Icon(
                        _isFlashOn.value
                            ? Icons.flash_on_rounded
                            : Icons.flash_off_rounded,
                        color: ColorConfig.blackText,
                        size: 16,
                      ),
                    );
                  }),
                ],
              ),
            ),
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
                  ElevatedButton(
                    onPressed: (() => Get.back()),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.grey,
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(60, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
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

  void _onQRViewCreated(QRViewController controller) {
    _qrController = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        _result = scanData;
      });
    });
  }

  @override
  void dispose() {
    _qrController?.dispose();
    super.dispose();
  }
}
