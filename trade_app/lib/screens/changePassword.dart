import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:trade_app/widgets/reusableWidget.dart';

import '../services/userAction.dart';

class changePasswordPage extends StatefulWidget {
  static const String routeName = '/changePassword';

  const changePasswordPage({super.key});
  @override
  State<changePasswordPage> createState() => _changePasswordState();
}

class _changePasswordState extends State<changePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final oldPassword = TextFormField(
      textInputAction: TextInputAction.next,
      controller: oldPasswordController,
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) return 'You need to enter your old password for verification.';
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Old Password',
        contentPadding: EdgeInsets.fromLTRB(4.w, 2.w, 4.w, 2.w),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
    );

    final newPassword = TextFormField(
      textInputAction: TextInputAction.done,
      controller: newPasswordController,
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      validator: (value) {
        if (value == null || value.isEmpty) return 'You need to enter a new password';
        return null;
      },
      decoration: InputDecoration(
        hintText: 'New Password',
        contentPadding: EdgeInsets.fromLTRB(4.w, 2.w, 4.w, 2.w),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
    );

    final headerDisplayText = Text('Reset Password', style: TextStyle(fontSize: 20.0.sp), textAlign: TextAlign.center);

    final resetButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.lightBlueAccent.shade100,
        minimumSize: Size(3.w, 5.h),
        elevation: 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // If the form is valid, display a snackbar. In the real world,
          // you'd often call a server or save the information in a database.
          AuthService().changeUserPassword(
            context: context,
            oldPassword: oldPasswordController.text,
            newPassword: newPasswordController.text
          );
          ScaffoldMessenger.of(context).showSnackBar( const SnackBar( content: Text('Your password has updated. Please login again')));
        }
      },
      child: const Text('Reset Password'),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ReusableWidgets.persistentAppBar('Reset Password'),
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 7.0.w, right: 7.0.w),
          children: <Widget>[
            SizedBox(height: 2.h),
            headerDisplayText,
            SizedBox(height: 1.h),
            oldPassword,
            SizedBox(height: 1.h),
            newPassword,
            SizedBox(height: 1.h),
            resetButton,
          ],
        ),
      ),
    );
  }
}
