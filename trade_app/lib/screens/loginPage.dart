import 'package:flutter/material.dart';
import 'package:trade_app/widgets/reusableWidget.dart';
import 'package:trade_app/services/userAction.dart';
import 'package:sizer/sizer.dart';

class loginPage extends StatefulWidget {
  static String tag = 'login-page';
  static const String routeName = '/login';
  const loginPage({super.key});
  
  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final email = TextFormField(
      textInputAction: TextInputAction.next,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      enableSuggestions: false,
      autocorrect: false,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter your email';
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(4.w, 2.w, 4.w, 2.w),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
    );
    
    final backgroundDisplayImg = SizedBox(
      width: 40.w,
      height: 40.h,
      child: Center( child: Image.asset("assets/cover.jpg"))
    );

    final password = TextFormField(
      textInputAction: TextInputAction.done,
      controller: passwordController,
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the password';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(4.w, 2.w, 4.w, 2.w),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
    );

    final headerDisplayText = Text('Login', style: TextStyle(fontSize: 20.0.sp));

    final registerButton = TextButton(
      onPressed: () { Navigator.pushNamed( context, "/register"); },
      child: const Text("Don't have an account? Sign up!"),
    );

    final loginButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.lightBlueAccent.shade100,
        minimumSize: Size(3.w, 5.h),
        elevation: 6.0,
        padding: EdgeInsets.all(2.h), // Add padding here
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () {
        // Validate returns true if the form is valid, or false otherwise.
        // print(emailController.text);
        // print(passwordController.text);
        if (_formKey.currentState!.validate()) {
          // If the form is valid, display a snackbar. In the real world,
          // you'd often call a server or save the information in a database.
          AuthService().signInUser(
            context: context,
            email: emailController.text,
            password: passwordController.text
          );
          ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text('Logging in...')));
        }
      },
      child: const Text('Login'),
    );

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: ReusableWidgets.persistentAppBar('Welcome to Trade Book'),
        body: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(left: 7.0.w, right: 7.0.w),
            children: <Widget>[
              SizedBox(height: 2.h),
              headerDisplayText,
              SizedBox(height: 1.h),
              backgroundDisplayImg,
              SizedBox(height: 1.h),
              email,
              SizedBox(height: 2.h),
              password,
              SizedBox(height: 2.h),
              loginButton,
              SizedBox(height: 1.h),
              registerButton
            ],
          ),
        ),
      )
    );
  }
}
