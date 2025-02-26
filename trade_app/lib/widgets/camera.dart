// when user clicks the book button
// first user will be redirected to camera page to scan the book
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sizer/sizer.dart';
import 'package:trade_app/widgets/reusableWidget.dart';
import '../services/book/bookService.dart';

class Camera extends StatefulWidget {
  static const String routeName = '/camera';
  const Camera({Key? key}) : super(key: key);

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  BarcodeCapture? barcode;
  MobileScannerController cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
    detectionTimeoutMs: 500,
  );

  @override
  void initState() {
     // To fix on start error
    cameraController.stop();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.persistentAppBar('Scan ISBN Code'),
      body: Stack(
        children: <Widget>[
          MobileScanner( // need to show each barcode at a time, do not allow multiple codes
            controller: cameraController,
            onDetect: (capture) { 
              final List<Barcode> barcodes = capture.barcodes;
              // for (final barcode in barcodes) {
              //   debugPrint('Barcode found! ${barcode.rawValue}');
              // }
              bookService().bookInfo(context, barcodes[0]);
            }
          ),
          Positioned(
            bottom: 8.h,
            right: 4.w,
            child: FloatingActionButton(
              heroTag: 1,
              onPressed: () => cameraController.switchCamera(),
              child: ValueListenableBuilder(
                valueListenable: cameraController.cameraFacingState,
                builder: (context, state, child) {
                  switch (state) {
                    case CameraFacing.front: return const Icon(Icons.camera_front);
                    case CameraFacing.back: return const Icon(Icons.camera_rear);
                  }
                },
              )
            )
          ),
          Positioned(
            bottom: 8.h, 
            left: 4.w, 
            child: FloatingActionButton(
              heroTag: 2,
              onPressed: () => cameraController.toggleTorch(),
              child: ValueListenableBuilder(
                valueListenable: cameraController.torchState,
                builder: (context, state, child) {
                  switch (state) {
                    case TorchState.off: return const Icon(Icons.flash_off, color: Colors.grey);
                    case TorchState.on: return const Icon(Icons.flash_on, color: Colors.yellow);
                  }
                }
              ),
            ),
          )
        ]
      )
    );
  }
}