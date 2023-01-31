// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../reusable_widgets/reusable_widgets.dart';
// import './signup_screen.dart';
// import './reset_password.dart';
// import './welcome_screen.dart';
// import '../widgets/gmail_login.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _passwordTextController = TextEditingController();
//   final TextEditingController _emailTextController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 64, 29, 161),
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.fromLTRB(
//                 20, MediaQuery.of(context).size.height * 0.2, 20, 0),
//             child: Column(
//               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 logoWidget("assets/images/logo1.jpg"),
//                 const SizedBox(height: 20),
//                 reusableTextField('Enter UserName', Icons.person_outline, false,
//                     _emailTextController),
//                 const SizedBox(height: 20),
//                 reusableTextField('Enter Password', Icons.lock_outline, true,
//                     _passwordTextController),
//                 forgotPassword(context),
//                 const SizedBox(height: 20),
//                 FirebaseButton(context, "LOG IN", () {
//                   // FirebaseAuth.instance
//                   //     .signInWithEmailAndPassword(
//                   //         email: _emailTextController.text,
//                   //         password: _passwordTextController.text)
//                   //     .then((value) {
//                   //   Navigator.push(
//                   //       context,
//                   //       MaterialPageRoute(
//                   //           builder: (context) => const WelcomeScreen()));
//                   //   //.onError((error, stackTrace) {});
//                   // });
//                 }),
//                 GmailLogin(),
//                 const SizedBox(height: 20),
//                 signupOption(context)
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// Row signupOption(context) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       const Text(
//         "Don't have account?",
//         style: TextStyle(
//           color: Colors.black45,
//         ),
//       ),
//       GestureDetector(
//         onTap: () {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => SignUpScreen()));
//         },
//         child: const Text(
//           "Sign Up",
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//       ),
//     ],
//   );
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_rent/form_screen.dart';
import '../reusable_widgets/reusable_widgets.dart';
import './signup_screen.dart';
import './welcome_screen.dart';
import './reset_password.dart';
import '../widgets/gmail_login.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  bool _obscureText = true; //sets for confirm password

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  logoWidget("assets/images/logo1.jpg"),
                  Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "Enter your email",
                            prefixIcon: Icon(Icons.email_outlined)),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please Enter Email";
                          } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return "Please Enter a Valid Email";
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          _email = value;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        obscureText: _obscureText,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
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
                            prefixIcon: Icon(Icons.lock_outline)),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please enter your password";
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          _password = value;
                        },
                      ),
                      SizedBox(height: 20),
                      forgotPassword(context),
                      FirebaseButton(context, 'LOG IN', () {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: _email.toString(),
                                password: _password.toString())
                            .then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WelcomeScreen()));
                        });
                      }),
                      const SizedBox(height: 20),
                      GmailLogin(),
                      SizedBox(height: 20),
                      signupOption(context)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget forgotPassword(BuildContext context) {
  return Container(
    alignment: Alignment.centerRight,
    height: 35,
    width: MediaQuery.of(context).size.width,
    child: TextButton(
      child: const Text(
        'Forgot Password',
        style: TextStyle(color: Colors.blue),
      ),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ResetPassword()));
      },
    ),
  );
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
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FormScreen()));
        },
        child: const Text(
          "Sign Up",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}
