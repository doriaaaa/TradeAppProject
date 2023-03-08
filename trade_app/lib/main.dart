import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trade_app/screens/loginPage.dart';
import 'package:trade_app/screens/uploadPage.dart';
import 'package:trade_app/routes/router.dart';
import 'package:provider/provider.dart';
import 'package:trade_app/provider/user_provider.dart';
// import '../widgets/nav_bar.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ], 
    child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var res = jsonEncode({
      "title": "Harry Potter and the Chamber of Secrets",
      "authors": [
        "J. K. Rowling"
      ],
      "publisher": "Bloomsbury Publishing",
      "publishedDate": "1999",
      "description": "HARRY POTTER is a wizard. He is in his second year at Hogwarts School of Witchcraft and Wizardry. Little does he know that this year will be just as eventful as the last.",
      "industryIdentifiers": [
        {
          "type": "ISBN_10",
          "identifier": "0747544077"
        },
        {
          "type": "ISBN_13",
          "identifier": "9780747544074"
        }
      ],
      "readingModes": {
        "text": false,
        "image": false
      },
      "pageCount": 251,
      "printType": "BOOK",
      "categories": [
        "Children's stories"
      ],
      "averageRating": 4.5,
      "ratingsCount": 2285,
      "maturityRating": "NOT_MATURE",
      "allowAnonLogging": false,
      "contentVersion": "preview-1.0.0",
      "panelizationSummary": {
        "containsEpubBubbles": false,
        "containsImageBubbles": false
      },
      "imageLinks": {
        "smallThumbnail": "http://books.google.com/books/content?id=R6ZpAAAACAAJ&printsec=frontcover&img=1&zoom=5&source=gbs_api",
        "thumbnail": "http://books.google.com/books/content?id=R6ZpAAAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api"
      },
      "language": "en",
      "previewLink": "http://books.google.com.hk/books?id=R6ZpAAAACAAJ&dq=isbn:9780747544074&hl=&cd=1&source=gbs_api",
      "infoLink": "http://books.google.com.hk/books?id=R6ZpAAAACAAJ&dq=isbn:9780747544074&hl=&source=gbs_api",
      "canonicalVolumeLink": "https://books.google.com/books/about/Harry_Potter_and_the_Chamber_of_Secrets.html?hl=&id=R6ZpAAAACAAJ"
    });

    return MaterialApp(
      title: 'Trade App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const loginPage(),
      // home: uploadPage(
      //   screenClosed: () { false; }, 
      //   bookInfoDetails: res
      // ),
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}
