// this button will allow user to select image
// image url and chunks are sent to the server directly
// backend server should have an upload image api and delete image api
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:trade_app/services/book/bookService.dart';
import '../constants/utils.dart';

class uploadBookPage extends StatefulWidget {
  final String bookInfoDetails;
  final Function() screenClosed;
  
  const uploadBookPage({
    Key? key,
    required this.bookInfoDetails, // pass the json file? widget.value to access the information
    required this.screenClosed,
  }) : super(key: key);

  @override
  State<uploadBookPage> createState() => _uploadBookPageState();
}

class _uploadBookPageState extends State<uploadBookPage> {

  File? pickedImage;
  bool isPicked = false;
  String? base64Image;
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
          // final _imageFile = image_process.decodeImage( pickedImage!.readAsBytesSync());
          // base64Image = base64Encode(image_process.encodePng(_imageFile!));
          // debugPrint(base64Image);
          setState(() { isPicked = true; });
        }
      },
      child: Container(
        width: 50.w,
        height: 50.w,
        decoration: BoxDecoration( borderRadius: BorderRadius.circular(10.0), color: const Color.fromARGB(100, 217, 217, 217)),
        child: isPicked ? Image.file( pickedImage!, width: 50.w, height: 50.w, fit: BoxFit.fill)
          : Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration( borderRadius: BorderRadius.circular(10.0), color: const Color.fromARGB(100, 217, 217, 217)),
              child: Icon( Icons.attachment, color: Colors.grey[800]),
            ),
      )
    );

    final bookInfoDisplayBox = <Widget>[
      Row( children: <Widget>[ Flexible(child: Text("Title: ${extractedDetails['title']}"))]),
      SizedBox(height: 1.h),
      Row( children: <Widget>[ Flexible(child: Text("First Author: ${extractedDetails['authors'][0] ?? "not specified" }"))]),
      SizedBox(height: 1.h),
      Row( children: <Widget>[ Flexible(child: Text("Published Date: ${extractedDetails['publishedDate'] ?? "not specified" }"))]),
      SizedBox(height: 1.h),
      Row( children: <Widget>[ Flexible(child: Text("Publisher: ${extractedDetails['publisher'] ?? "not specified" }"))]),
      SizedBox(height: 1.h),
      Row( children: <Widget>[ Flexible(
        child: Text("Summary: ${ (extractedDetails['description'].length > 50 ? extractedDetails['description'].substring(0,50)+"..." : extractedDetails['description']) ?? "not specified" }")
      )]),
    ];

    return Scaffold(
      // allow user to go back to previous page
      appBar: AppBar(
        centerTitle: true,
        actions: <Widget>[
          IconButton( 
            onPressed: () {
              // send request to backend server
              // only need to validate the photo?
              if (_formKey.currentState!.validate()) { 
                bookService().universalImage(
                  context: context,
                  image: pickedImage, // should pass image value
                  bookInfo: widget.bookInfoDetails,
                );
              } else {
                showSnackBar( context,'Missing photo / description');
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
          padding: EdgeInsets.only(left: 4.w, right: 4.w),
          children: <Widget>[
            SizedBox(height: 4.h),
            // row need position the box
            Row( 
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Expanded(child: Column( children: <Widget>[uploadImageButton])),
                SizedBox(width: 1.w),
                Expanded(child: Column( children: bookInfoDisplayBox))
              ]
            ),
            SizedBox(height: 4.h),
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