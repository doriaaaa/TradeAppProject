// load other user data when user clicks in icon / name tag
// username, profilePicture, bookList, threads? 
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class userPage extends StatefulWidget {
  // need userId and call api
  const userPage({Key? key}) : super(key: key);

  @override
  State<userPage> createState() => _userPageState();
}

class _userPageState extends State<userPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}