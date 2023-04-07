// this button will allow user to select image
// image url and chunks are sent to the server directly
// backend server should have an upload image api and delete image api
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:trade_app/services/book/bookService.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../constants/utils.dart';

class BookPage extends StatefulWidget {
  final String bookInfo;
  // final Function() screenClosed;

  const BookPage({
    Key? key,
    required this.bookInfo, // pass the json file? widget.value to access the information
    // required this.screenClosed,
  }) : super(key: key);

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  File? pickedImage;
  bool isPicked = false;
  String? base64Image;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Map info = json.decode(widget.bookInfo); // map json response
    // print("info['authors'].length ${info['authors'].length}");
    String author = (info.containsKey('authors') && info['authors'].length != 0) ? info['authors'][0] : "unknown";
    String category = (info.containsKey('categories') && info['categories'].length != 0) ? info['categories'][0] : "not classified";
    double rating = info.containsKey('averageRating') ? double.parse(info['averageRating'].toString()) : 0.0;
    String description = info.containsKey('description') ? info['description'] : "Description is not available.";

    final displayImageBox = GestureDetector(
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
          setState(() {
            isPicked = true;
          });
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 12.0.w, right: 12.0.w),
        width: 50.w,
        height: 60.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color.fromARGB(100, 217, 217, 217)
        ),
        child: isPicked
          ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: FileImage(pickedImage!), fit: BoxFit.cover
              )
            ))
          : Container(
              padding: EdgeInsets.only(left: 10.0.w, right: 10.0.w),
              width: 50.w,
              height: 60.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color.fromARGB(100, 217, 217, 217)
              ),
              child: Icon(Icons.attachment, color: Colors.grey[800]),
            ),
      )
    );

    final displayBookTitleText = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Text(
            "${info['title']}",
            textAlign: TextAlign.start,
            style: TextStyle( fontSize: 14.sp, fontWeight: FontWeight.bold)
          )
        )
      ]
    );

    final displayBookAuthorText = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child:Text(
            "By $author",
            textAlign: TextAlign.start,
            style: TextStyle( fontSize: 8.sp)
          )
        )
      ]
    );
    
    // only list two tags
    final categoryTag = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(1.5.w),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF5E2750)),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            category, 
            style: TextStyle( 
              fontSize: 10.sp,
              color: const Color(0xFF5E2750)
            )
          )
        ),
      ]
    );

    // list out ratings and pages
    final ratingDisplayBox = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: RatingBarIndicator(
            rating: rating,
            itemBuilder: (context, index) => 
            const Icon( Icons.star,  color: Colors.amber),
            itemCount: 5,
            itemSize: 20.0,
            direction: Axis.horizontal,
          ),
        )
      ]
    );

    final descriptionBox = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
          Text( 
            description, 
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 12.0.sp, height: 1.0),
          )
        // )
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Details"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              // send request to backend server
              // only need to validate the photo?
              if (_formKey.currentState!.validate()) {
                bookService().universalImage(
                  context: context,
                  image: pickedImage, // should pass image value
                  bookInfo: widget.bookInfo,
                );
              } else {
                showSnackBar(context, 'Missing photo!');
              }
            },
          )
        ],
        leading: IconButton(
          onPressed: () { Navigator.pop(context); },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        flexibleSpace: const Image(
          image: AssetImage('assets/book_title.jpg'), 
          fit: BoxFit.cover
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.only(left: 7.0.w, right: 7.0.w, top: 2.h),
          children: <Widget>[
            displayImageBox,
            SizedBox(height: 1.h),
            displayBookTitleText,
            SizedBox(height: 0.5.h),
            displayBookAuthorText,
            SizedBox(height: 1.h),
            ratingDisplayBox,
            SizedBox(height: 1.h),
            categoryTag,
            SizedBox(height: 1.h),
            descriptionBox,
            SizedBox(height: 1.h),
          ],
        )
      )
    );
  }
}
