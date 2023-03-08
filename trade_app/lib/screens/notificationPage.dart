import 'package:flutter/material.dart';
import 'package:trade_app/widgets/reusableWidget.dart';

class notificationPage extends StatefulWidget {
  static const String routeName = '/notification';
  const notificationPage({Key? key}) : super(key: key);

  @override
  State<notificationPage> createState() => _notificationPageState();
}

class _notificationPageState extends State<notificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.persistentAppBar('Notifications'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/notification.png'),
          ),
          const Text( 'No notification so far', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25))
        ],
      ),
    );
  }
}
