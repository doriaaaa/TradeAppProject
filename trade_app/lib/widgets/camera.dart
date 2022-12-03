import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:trade_app/services/auth/connector.dart';

class ISBN_info {
  final String title;
  final String publishedDate;

  ISBN_info({required this.title, required this.publishedDate});

  factory ISBN_info.fromJson(Map<String, dynamic> json) {
    final title = json['title'] as String;
    final publishedDate = json['publishedDate'] as String;
    return ISBN_info(title: title, publishedDate: publishedDate);
  }
}

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  MobileScannerController cameraController = MobileScannerController();
  bool _screenOpened = false;
  String serverResponse = 'Server response';

  Future<String> getBookData(Barcode barcode, MobileScannerArguments? args) async {

    if (!_screenOpened) {
      final String code = barcode.rawValue ?? "---";
      // final String code = "9780733426094";
      if (code != "---") {
        // debugPrint('Barcode found! $code');
        var res = await http.post(
          Uri.parse('http://172.20.10.4:3000/api/bookinfo'), 
          body: jsonEncode({
            "book_isbn": code
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          }
        );
        var resBody = json.decode(res.body);
        _screenOpened = true;
        debugPrint(code);
        debugPrint(resBody['title']); // can print title
        // ignore: use_build_context_synchronously
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => FoundCodeScreen(screenClosed: _screenWasClosed, value: resBody))
        );
      }
    }
    return "Success!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mobile Scanner"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state as TorchState) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state as CameraFacing) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        allowDuplicates: true,
        controller: cameraController,
        onDetect: getBookData,
      ),
    );
  }

  // void _foundBarcode(Barcode barcode, MobileScannerArguments? args) {
  //   /// open screen
  //   if (!_screenOpened) {
  //     final String code = barcode.rawValue ?? "---";
  //     if (code != "---") {
        
  //     }
  //     debugPrint('Barcode found! $code');
  //     _screenOpened = true;
  //     Navigator.push(
  //       context, 
  //       MaterialPageRoute(builder: (context) => FoundCodeScreen(screenClosed: _screenWasClosed, value: code),)
  //     );
  //   }
  // }

  void _screenWasClosed() {
    _screenOpened = false;
  }
}

class FoundCodeScreen extends StatefulWidget {
  final String value;
  final Function() screenClosed;
  const FoundCodeScreen({
    Key? key,
    required this.value,
    required this.screenClosed,
  }) : super(key: key);

  @override
  State<FoundCodeScreen> createState() => _FoundCodeScreenState();
}

class _FoundCodeScreenState extends State<FoundCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Found Code"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            widget.screenClosed();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_outlined,),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Scanned Code:", style: TextStyle(fontSize: 20,),),
              const SizedBox(height: 20,),
              Text(widget.value, style: const TextStyle(fontSize: 16,),), 
            ],
          ),
        ),
      ),
    );
  }
}