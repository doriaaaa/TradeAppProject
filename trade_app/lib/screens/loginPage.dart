import 'package:flutter/material.dart';
import 'package:trade_app/widgets/reusableWidget.dart';
import 'package:trade_app/services/auth/connector.dart';

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
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter your email';
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    
    final bg = SizedBox(
        width: 300,
        height: 200,
        child: FittedBox( fit: BoxFit.fitWidth, child: Image.asset("assets/overlay.png") //add your image url if its from network if not change it to image.asset
      )
    );

    final password = TextFormField(
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
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    const heading = Text.rich( TextSpan( text: 'Login', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)));

    final registerButton = TextButton(
      onPressed: () { Navigator.pushNamed( context, "/register"); },
      child: const Text("Don't have an account? Sign up!"),
    );

    final loginButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.lightBlueAccent.shade100,
        minimumSize: const Size(350, 50),
        elevation: 5.9,
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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logging in...')),
          );
        }
      },
      child: const Text('Login'),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ReusableWidgets.persistentAppBar('Welcome to Trade Book'),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            const SizedBox(height: 60.0),
            heading,
            const SizedBox(height: 75.0),
            bg,
            const SizedBox(height: 75.0),
            email,
            const SizedBox(height: 8.0),
            password,
            const SizedBox(height: 24.0),
            loginButton,
            const SizedBox(height: 5.0),
            registerButton
          ],
        ),
      ),
    );
  }
}
