// this button will allow user to select image
// image url and chunks are sent to the server directly
// backend server should have an upload image api and delete image api
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as ImageProcess;
import '../services/upload.dart';

class uploadImagePage extends StatefulWidget {
  final String bookInfoDetails;
  final Function() screenClosed;
  
  uploadImagePage({
    Key? key,
    required this.bookInfoDetails, // pass the json file? widget.value to access the information
    required this.screenClosed,
  }) : super(key: key);

  @override
  State<uploadImagePage> createState() => _uploadImagePageState();
}

class _uploadImagePageState extends State<uploadImagePage> {

  File? pickedImage;
  bool isPicked = false;
  final _formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  
  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map extractedDetails = json.decode(widget.bookInfoDetails); // map json response
    // upload image box
    final uploadImageButton = GestureDetector(
      onTap: () async {
        ImagePicker picker = ImagePicker();
        XFile? image = await picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          pickedImage = File(image.path);
          debugPrint(image.path);
          // get base64 image
          final _imageFile = ImageProcess.decodeImage( pickedImage!.readAsBytesSync());
          String base64Image = base64Encode(ImageProcess.encodePng(_imageFile!));
          // debugPrint(base64Image);
          // print(base64Image);
          setState(() { isPicked = true; });
        }
      },
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration( borderRadius: BorderRadius.circular(10.0), color: const Color.fromARGB(100, 217, 217, 217)),
        child: isPicked ? Image.file( pickedImage!, width: 200.0, height: 200.0, fit: BoxFit.fitHeight)
          : Container(
              decoration: BoxDecoration( borderRadius: BorderRadius.circular(10.0), color: const Color.fromARGB(100, 217, 217, 217)),
              width: 200, height: 200, child: Icon( Icons.attachment, color: Colors.grey[800]),
            ),
      )
    );

    final bookInfoDisplayBox = <Widget>[
      Row( children: <Widget>[ Flexible(child: Text("Title: ${extractedDetails['title']}"))]),
      const SizedBox(height: 10),
      Row( children: <Widget>[ Flexible(child: Text("First Author: ${extractedDetails['authors'][0] ?? "not specified" }"))]),
      const SizedBox(height: 10),
      Row( children: <Widget>[ Flexible(child: Text("Published Date: ${extractedDetails['publishedDate'] ?? "not specified" }"))]),
      const SizedBox(height: 10),
      Row( children: <Widget>[ Flexible(child: Text("Publisher: ${extractedDetails['publisher'] ?? "not specified" }"))]),
      const SizedBox(height: 10),
      Row( children: <Widget>[ Flexible(
        child: Text("Summary: ${ (extractedDetails['description'].length > 50 ? extractedDetails['description'].substring(0,50)+"..." : extractedDetails['description']) ?? "not specified" }")
      )]),
    ];

    return Scaffold(
      // allow user to go back to previous page
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        actions: <Widget>[
          IconButton( 
            onPressed: () {
              // send request to backend server
              // only need to validate the photo?
              if (_formKey.currentState!.validate()) { 
                uploadService().uploadPost(
                  context: context,
                  imageURL: pickedImage,
                  bookInfo: widget.bookInfoDetails
                );
              }
            }, 
            icon: const Icon( Icons.thumb_up_alt_outlined ),
          )
        ],
        leading: IconButton(
          onPressed: () { Navigator.pop(context);},
          icon: const Icon( Icons.arrow_back_outlined ),
        ),
        flexibleSpace: const Image( image: AssetImage('assets/book_title.jpg'), fit: BoxFit.cover),
      ),
      // have to create a box to put the image
      // text area to print out the book info
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          children: <Widget>[
            const SizedBox(height: 30),
            // row need position the box
            Row( 
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Expanded(child: Column( children: <Widget>[uploadImageButton])),
                const SizedBox(width:10),
                Expanded(child: Column( children: bookInfoDisplayBox))
              ]
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Expanded(
                  child: TextFormField( 
                    controller: descriptionController,
                    maxLines: 6,
                    decoration: InputDecoration( 
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)), 
                      hintText: 'Input description here...'
                    )
                  )
                )
              ],
            )
          ]
        )
      ),
    );
  }
}