import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final slide = ImageSlideshow(
      indicatorColor: Colors.blue,
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
            "http://books.google.com/books/content?id=T929zgEACAAJ&printsec=frontcover&img=1&zoom=5&source=gbs_api"),
      ],
    );
    // final logo = Hero(
    //   tag: 'hero',
    //   child: CircleAvatar(
    //     backgroundColor: Colors.transparent,
    //     radius: 48.0,
    //     child: Image.network(
    //         'http://books.google.com/books/content?id=-VfNSAAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api'),
    //   ),
    // );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final heading = Text.rich(
      TextSpan(
        text: 'Login',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        // default text style
      ),
    );
    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.9,
        child: MaterialButton(
          minWidth: 200,
          height: 42,
          onPressed: () {},
          color: Colors.lightBlueAccent,
          child: Text('Log in', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    // final forgotLabel = FlatButton(
    //   child: Text(
    //     'Forgot password?',
    //     style: TextStyle(color: Colors.black54),
    //   ),
    //   onPressed: () {},
    // );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Welcome to Trade Book',
        ),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            heading,
            //logo,
            slide,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
          ],
        ),
      ),
    );
  }
}
