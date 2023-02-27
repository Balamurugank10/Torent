import 'package:flutter/material.dart';
//import 'package:to_rent/register_page.dart';
import 'package:to_rent/screens/login_screen.dart';
import 'package:to_rent/screens/signup_screen.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  //Initially show login page
  bool showLogInPage = true;

  //toggle between login and register page
  void togglePages() {
    setState(() {
      showLogInPage = !showLogInPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogInPage) {
      return LoginScreen(
        onTap: togglePages,
      );
    } else {
      return SignUpScreen(
        onTap: togglePages,
      );
    }
  }
}
