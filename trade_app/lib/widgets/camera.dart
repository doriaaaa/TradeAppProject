import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:trade_app/widgets/reusable_widget.dart';

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
  int counter = 0;
  Future<String> getBookData(Barcode barcode, MobileScannerArguments? args) async {
    if (!_screenOpened) {
      final String code = barcode.rawValue ?? "---";
      counter++;
      // final String code = "9780733426094";
      if (code != "---" && counter == 1) {
        debugPrint('Barcode found! $code');
        var res = await http.post(
          // set phone's ip
          Uri.parse('http://172.20.10.4:3000/api/bookinfo'),
          body: jsonEncode({"book_isbn": code}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          }
        );
        var resBody = json.decode(res.body);
        _screenOpened = true;
        String stringValue = counter.toString();
        debugPrint(stringValue);
        debugPrint(code);
        debugPrint(resBody['title']); // can print title
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FoundCodeScreen(
                screenClosed: _screenWasClosed, value: resBody['title']
              )
          )
        );
      }
    }
    return "Success!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.persistentAppBar("Scan ISBN Code"),
      body: Stack(
        children: <Widget>[
          MobileScanner(
            allowDuplicates: true,
            controller: cameraController,
            onDetect: getBookData,
          ),
          Positioned(
            bottom: 60,
            right: 20,
            child: FloatingActionButton(
              heroTag: 1,
              onPressed: () => cameraController.switchCamera(),
              child: ValueListenableBuilder(
                valueListenable: cameraController.cameraFacingState,
                builder: (context, state, child) {
                  switch (state) {
                    case CameraFacing.front:
                      return const Icon(Icons.camera_front);
                    case CameraFacing.back:
                      return const Icon(Icons.camera_rear);
                  }
                },
              )
            )
          ),
          Positioned(
            bottom: 60, 
            left: 20, 
            child: FloatingActionButton(
              heroTag: 1,
              onPressed: () => cameraController.toggleTorch(),
              child: ValueListenableBuilder(
                valueListenable: cameraController.torchState,
                builder: (context, state, child) {
                  switch (state) {
                    case TorchState.off:
                      return const Icon(Icons.flash_off, color: Colors.grey);
                    case TorchState.on:
                      return const Icon(Icons.flash_on, color: Colors.yellow);
                  }
                }
              ),
            ),
          )
        ]
      )
    );
  }

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
          icon: const Icon(
            Icons.arrow_back_outlined,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Scanned Code:",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.value,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
