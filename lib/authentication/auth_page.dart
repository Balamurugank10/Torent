import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_rent/authentication/login_or_register_page.dart';

import 'package:to_rent/screens/main_screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance
            .authStateChanges(), //Checks logged In or Not...
        builder: (context, snapshot) {
          //User is Logged in
          if (snapshot.hasData) {
            return const MainScreen();
          }

          //User is not Logged in
          else {
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
