import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:trade_app/widgets/reusableWidget.dart';
import 'package:trade_app/services/auth/connector.dart';

class registerPage extends StatefulWidget {
  static const String routeName = '/register';
  static String tag = 'register-page';
  const registerPage({super.key});
  
  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final username = TextFormField(
      controller: nameController,
      enableSuggestions: false,
      autocorrect: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'You need a brilliant username for your account!';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Username',
        contentPadding: EdgeInsets.fromLTRB(4.w, 2.w, 4.w, 2.w),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
    );

    final email = TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'You need to have an email account to register!';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Enter your email',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      controller: passwordController,
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Password';
        if (value != _confirmPass.text) return 'Not Match';
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Enter your password',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final verifyPassword = TextFormField(
      controller: _confirmPass,
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Verify Password';
        if (value != passwordController.text) return 'Not Match';
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Verify Password',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final backgroundDisplayImg = SizedBox(
      width: 5.w,
      height: 20.h,
      child: FittedBox( fit: BoxFit.fitWidth, child: Image.asset("assets/createAccount.jpg"))
    );

    final headerDisplayText = Text('Sign up', style: TextStyle(fontSize: 30.0.sp));

    final registerButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.lightBlueAccent.shade100,
        minimumSize: const Size(350, 50),
        elevation: 5.9,
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0)),
      ),
      child: const Text('Register'),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          AuthService().signUpUser(
            context: context,
            email: emailController.text,
            password: passwordController.text,
            name: nameController.text,
          );
          ScaffoldMessenger.of(context).showSnackBar( const SnackBar( content: Text('Your account has been created successfully.')));
        }
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ReusableWidgets.persistentAppBar('Create New Account'),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.only(left: 7.0.w, right: 7.0.w),
          children: <Widget>[
            SizedBox(height: 3.h),
            headerDisplayText,
            SizedBox(height: 7.h),
            backgroundDisplayImg,
            SizedBox(height: 5.h),
            username,
            SizedBox(height: 2.h),
            email,
            SizedBox(height: 2.h),
            password,
            SizedBox(height: 2.h),
            verifyPassword,
            SizedBox(height: 3.h),
            registerButton,
          ],
        ),
      ),
    );
  }
}
