import 'package:flutter/material.dart';
import 'package:trade_app/widgets/app_title_homepage.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  final slide = ImageSlideshow(
    indicatorColor: Colors.white,
    onPageChanged: (value) {
      debugPrint('Page changed: $value');
    },
    autoPlayInterval: 3000,
    isLoop: true,
    children: [
      Image.network(
          "http://books.google.com/books/content?id=-VfNSAAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api"),
      Image.network(
          "http://books.google.com/books/content?id=fltxyAEACAAJ&printsec=frontcover&img=1&zoom=5&source=gbs_api"),
      Image.network(
          "http://books.google.com/books/content?id=T929zgEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api"),
    ],
  );

  final heading = Text.rich(
    TextSpan(
      text: 'Our\nLatest Recomandations! ',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
      // default text style
    ),
  );

  final category_text = Text.rich(
    TextSpan(
      text: 'Recomanded Categories',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
      // default text style
    ),
  );

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          AppTitle(),
          SizedBox(height: 70.0),
          heading,
          SizedBox(height: 20.0),
          slide,
          SizedBox(height: 20.0),
          category_text,
        ],
      ),
    );
  }
}
