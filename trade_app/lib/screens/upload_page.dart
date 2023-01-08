import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trade_app/widgets/reusable_widget.dart';
import 'package:trade_app/screens/bookInfodetail.dart';
import '/../widgets/camera.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File? pickedImage;
  bool isPicked = false;

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonStyle = OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      side: const BorderSide(
        color: Color.fromARGB(210, 10, 10, 10),
        width: 3
      ),
      minimumSize: const Size(350, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );

    buttonText (String text) {
      return Text(
        text, 
        style: const TextStyle(color: Color.fromARGB(210, 10, 10, 10))
      );
    }

    final scanISBNButton = OutlinedButton(
      style: buttonStyle,
      onPressed: () {
        //open camera widget
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Camera()));
      },
      child: buttonText("Scan ISBN"),
    );

    final cancelButton = OutlinedButton(
      style: buttonStyle,
      onPressed: () {
        //clear all the fields
      },
      child: buttonText('Cancel'),
    );

    final uploadImageButton = GestureDetector(
      onTap: () async {
        ImagePicker picker = ImagePicker();
        XFile? image = await picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          pickedImage = File(image.path);
          setState(() {
            isPicked = true;
          });
        }
      },
      child: Container(
        width: 350,
        height: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color.fromARGB(100, 217, 217, 217)
        ),
        child: isPicked
          ? Image.file(
              pickedImage!,
              width: 350.0,
              height: 350.0,
              fit: BoxFit.fitHeight,
            )
          : Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color.fromARGB(100, 217, 217, 217)
              ),
              width: 350,
              height: 350,
              child: Icon(
                Icons.camera_alt,
                color: Colors.grey[800],
              ),
            ),
      )
    );
    
    final viewDetailsButton = OutlinedButton(
      style: buttonStyle,
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const InfoDetailPage()));
        //this button should be disabled at first, if there is data fetched from ISBN, then it is enabled
      },
      child: buttonText('View details'),
    );

    final submitButton = OutlinedButton(
      style: buttonStyle,
      onPressed: () {
        //upload data to database
      },
      child: buttonText('Upload book'),
    );

    return MaterialApp(
      home: Scaffold(
        appBar: ReusableWidgets.persistentAppBar("Upload book"),
        body: Column(
          children: <Widget>[
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[uploadImageButton]
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[scanISBNButton]
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[viewDetailsButton]
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[submitButton]
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[cancelButton]
            ),
          ],
        )
      )
    );
  }
}
