import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import '../reusable_widgets/reusable_widgets.dart';
import './welcome_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  //const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Sign Up",
            style: TextStyle(
              color: Colors.amberAccent,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
          child: Column(
            children: [
              //logoWidget("assets/images/logo1.jpg"),
              reusableTextField('Enter UserName', Icons.person_outline, false,
                  _userNameTextController),
              const SizedBox(height: 20),
              reusableTextField('Enter Email Id', Icons.email_outlined, false,
                  _emailTextController),
              const SizedBox(height: 20),
              reusableTextField('Enter Password', Icons.lock_outline, true,
                  _passwordTextController),
              const SizedBox(height: 20),
              signButton(context, false, () {
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text)
                    .then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const WelcomeScreen())));
                });
              }),
              const SizedBox(height: 20),
            ],
          ),
        )),
      ),
    );
  }
}
