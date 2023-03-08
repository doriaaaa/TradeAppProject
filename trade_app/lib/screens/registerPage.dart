import 'package:flutter/material.dart';
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
    final name = TextFormField(
      controller: nameController,
      enableSuggestions: false,
      autocorrect: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your username';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Username',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final email = TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Registration Email',
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
        if (value == null || value.isEmpty) {
          return 'Password';
        }
        if (value != _confirmPass.text) return 'Not Match';
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password2 = TextFormField(
      controller: _confirmPass,
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Verify Password';
        }
        if (value != passwordController.text) return 'Not Match';
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Verify Password',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final bg = SizedBox(
      width: 300,
      height: 200,
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Image.asset("assets/books.png") //add your image url if its from network if not change it to image.asset
      )
    );

    const heading = Text.rich( TextSpan( text: 'Register Account', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)));

    final loginButton = ElevatedButton(
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
          ScaffoldMessenger.of(context).showSnackBar( const SnackBar( content: Text('Registered successfully, please login')));
        }
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ReusableWidgets.persistentAppBar('Welcome to Trade Book'),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            const SizedBox(height: 30.0),
            heading,
            const SizedBox(height: 30.0),
            bg,
            const SizedBox(height: 30.0),
            name,
            const SizedBox(height: 15.0),
            email,
            const SizedBox(height: 15.0),
            password,
            const SizedBox(height: 15.0),
            password2,
            const SizedBox(height: 25.0),
            loginButton,
          ],
        ),
      ),
    );
  }
}
