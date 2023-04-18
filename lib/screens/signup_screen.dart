import 'package:flutter/material.dart';
import 'package:to_rent/services/auth_services.dart';
import '../reusable_widgets/reusable_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../reusable_widgets/my_button.dart';
import '../reusable_widgets/widget_tile.dart';
import 'package:email_validator/email_validator.dart';

class SignUpScreen extends StatefulWidget {
  final Function()? onTap;
  const SignUpScreen({super.key, required this.onTap});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  String? _confirmPassword;
  bool _obscureText = true;

  void signUpUser() async {
    // setState(() {
    //   if (_formKey.currentState!.validate()) {}
    // });

    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    //try sign up
    try {
      if (_password.toString() == _confirmPassword.toString()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _email.toString(), password: _password.toString());
      } else {
        showErrorMessage('Passwords Does not match');
      }

      // POP THE LOADING CIRCLE

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // POP THE LOADING CIRCLE
      Navigator.pop(context);

      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
        );
      },
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
            child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                logoWidget("assets/images/logo.png"),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Text('Let\'s create an account!',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    )),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Enter your email",
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                        validator: (value) =>
                            value != null && !EmailValidator.validate(value)
                                ? 'Enter a valid Email'
                                : null,
                        onChanged: (String? value) {
                          _email = value;
                        },
                        onSaved: (String? value) {
                          _email = value;
                        },
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        obscureText: _obscureText,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(_obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            labelText: "Enter your password",
                            prefixIcon: const Icon(Icons.lock_outline)),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please enter your password";
                          }
                          return null;
                        },
                        onChanged: (String? value) {
                          _password = value;
                        },
                        onSaved: (String? value) {
                          _password = value;
                        },
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        obscureText: _obscureText,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(_obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            labelText: "Renter your password",
                            prefixIcon: const Icon(Icons.lock_outline)),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please confirm your password";
                          }
                          if (value.toString() == _password.toString()) {
                            return "Password does not match";
                          }
                          return null;
                        },
                        onChanged: (String? value) {
                          _confirmPassword = value;
                        },
                        onSaved: (String? value) {
                          _confirmPassword = value;
                        },
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    MyButton(onTap: signUpUser, title: 'SIGN UP'),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or Continue with',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        Expanded(
                            child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ))
                      ]),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    WidgetTile(
                      imagePath: 'assets/images/Google.png',
                      imagePath2: 'assets/images/oogle.png',
                      onTap: (() => AuthServices().signInWithGoogle()),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            "Log in",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  ],
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
