import 'package:flutter/material.dart';
import 'package:trade_app/widgets/reusable_widget.dart';
import 'package:trade_app/screens/bookInfodetail.dart';
import '/../widgets/camera.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  @override
  Widget build(BuildContext context) {
    final ScanISBNButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
        minimumSize: const Size(350, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () {
        //open camera widget
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Camera()));
      },
      child: const Text('Scan ISBN'),
    );

    final CancelButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        minimumSize: const Size(350, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () {
        //clear all the fields
      },
      child: const Text('Cancel'),
    );

    final UploadImageButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
        backgroundColor: const Color.fromARGB(100, 217, 217, 217),
        minimumSize: const Size(350, 350),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () {
        //let user to choose photo from album
      },
      child: const Text('Upload image here'),
    );

    final ViewDetailsButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pinkAccent,
        minimumSize: const Size(350, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const InfoDetailPage()),
        );
        //this button should be disabled at first, if there is data fetched from ISBN, then it is enabled
      },
      child: const Text('View details'),
    );

    final SubmitButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        minimumSize: const Size(350, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () {
        //upload data to database
      },
      child: const Text('Upload book'),
    );

    return MaterialApp(
        home: Scaffold(
            appBar: ReusableWidgets.accountPageAppBar("Upload your book!"),
            backgroundColor: const Color.fromARGB(255, 157, 85, 169),
            body: Column(
              children: <Widget>[
                const SizedBox(height: 30),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[UploadImageButton]),
                const SizedBox(height: 30),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[ScanISBNButton]),
                const SizedBox(height: 30),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[ViewDetailsButton]),
                const SizedBox(height: 30),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[SubmitButton]),
                const SizedBox(height: 30),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[CancelButton]),
              ],
            )));
  }
}
