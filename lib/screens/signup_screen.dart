import 'package:flutter/material.dart';
import 'package:to_rent/services/auth_services.dart';
import '../reusable_widgets/reusable_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../reusable_widgets/my_button.dart';
import '../reusable_widgets/widget_tile.dart';
import './main_screen.dart';

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
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
            child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                logoWidget("assets/images/logo.png"),
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
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please Enter Email";
                          } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return "Please Enter a Valid Email";
                          }
                          return null;
                        },
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
                            return "Please enter your password";
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
                    //GmailLogin(),
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
                          //onTap: () {
                          //Navigator.push(
                          //    context, MaterialPageRoute(builder: (context) => LoginScreen()));
                          //},
                          child: const Text(
                            "Log in",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    // LoginOption(context),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    skipOption(context),
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

Widget skipOption(context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MainScreen()));
    },
    child: const Text(
      "Ask me Later",
      style: TextStyle(
          color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20),
    ),
  );
}
