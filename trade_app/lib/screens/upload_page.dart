import 'package:flutter/material.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('this is homepage'),
      ),
      body:Container(
        child: Text('this is upload page'),
      )
    );
  }
}
