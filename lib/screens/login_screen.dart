import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_rent/reusable_widgets/my_button.dart';
import 'package:to_rent/screens/forgot_password.dart';
import 'package:to_rent/services/auth_services.dart';
import '../reusable_widgets/reusable_widgets.dart';
import 'package:email_validator/email_validator.dart';
import '../reusable_widgets/widget_tile.dart';
import './main_screen.dart';

class LoginScreen extends StatefulWidget {
  final Function()? onTap;
  const LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _email;
  String? _password;
  bool _obscureText = true; //sets for confirm password

  //sign user in method
  void signInUser() async {
    setState(() {
      if (formKey.currentState!.validate()) {}
    });

    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.toString(), password: _password.toString());

      // POP THE LOADING CIRCLE
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // POP THE LOADING CIRCLE
      Navigator.pop(context);
      if (e.code == "wrong-password") {
        showErrorMessage(e.code);
      }
      if (e.code == "invalid-email") {
        showErrorMessage(e.code);
      }
      // showErrorMessage(e.code);
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

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    logoWidget("assets/images/logo.png"),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Text('Welcome back you\'ve been missed!',
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
                            autofillHints: const [AutofillHints.email],
                            decoration: InputDecoration(
                                labelText: "Enter your email",
                                fillColor: Colors.grey.shade200,
                                filled: true,
                                prefixIcon: const Icon(Icons.email_outlined)),
                            validator: (value) =>
                                value != null && !EmailValidator.validate(value)
                                    ? 'Enter a valid Email'
                                    : null,
                            onChanged: (val) {
                              _email = val;
                            },
                            onSaved: (String? value) {
                              _email = value;
                            },
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
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
                            onChanged: (val) {
                              _password = val;
                            },
                            onSaved: (String? value) {
                              _password = value;
                            },
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        forgotPassword(context),
                        MyButton(
                          onTap: signInUser,
                          title: 'LOG IN',
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(children: [
                            Expanded(
                                child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            )),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
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

                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        WidgetTile(
                          imagePath: 'assets/images/Google.png',
                          imagePath2: 'assets/images/oogle.png',
                          onTap: (() => AuthServices().signInWithGoogle()),
                        ),
                        //GmailLogin(),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have account?",
                              style: TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

Widget skipOption2(BuildContext context) {
  return TextButton(
    child: const Text(
      'Ask me Later',
      style: TextStyle(
          color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20),
    ),
    onPressed: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MainScreen()));
    },
  );
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

Widget forgotPassword(BuildContext context) {
  return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25.0,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        TextButton(
          child: const Text(
            'Forgot Password',
            style: TextStyle(color: Colors.blue),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ForgotPassword()));
          },
        )
      ]));
}

Row signupOption(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        "Don't have account?",
        style: TextStyle(
          color: Colors.black45,
        ),
      ),
      GestureDetector(
        child: const Text(
          "Sign Up",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}
