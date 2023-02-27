import 'package:flutter/material.dart';
import './screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FormScreen extends StatefulWidget {
  //const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String? _name;
  String? _email;
  String? _password;
  String? _confirmPassword;
  String? _phoneNumber;
  TextEditingController uname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pwd = TextEditingController();
  TextEditingController cpwd = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildNameField() {
    return TextFormField(
      controller: uname,
      decoration: InputDecoration(
          labelText: "Enter your name", prefixIcon: Icon(Icons.person_outline)),
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Please enter your name";
        }
        return null;
      },
      onSaved: (String? value) {
        _name = value;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: email,
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
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: pwd,
      obscureText: true,
      //keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
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
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: cpwd,
      //keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          labelText: "Confirm password", prefixIcon: Icon(Icons.lock_outline)),
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Please Re-enter your password";
        }
        if (pwd.text != cpwd.text) {
          return "Password Do not match";
        }
        return null;
      },
      onSaved: (String? value) {
        _confirmPassword = value;
      },
    );
  }

  Widget _buildPhoneNumberField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          labelText: "Mobile No", prefixIcon: Icon(Icons.phone_outlined)),
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Please enter your Mobile No";
        }
        if (value.length < 9) {
          return "Please enter a valid phone number";
        }
        return null;
      },
      onSaved: (String? value) {
        _phoneNumber = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "SIGN UP",
        textAlign: TextAlign.center,
      )),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        //margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNameField(),
                SizedBox(height: 20),
                _buildEmailField(),
                SizedBox(height: 20),
                _buildPasswordField(),
                SizedBox(height: 20),
                _buildConfirmPasswordField(),
                SizedBox(height: 20),
                _buildPhoneNumberField(),
                SizedBox(height: 20),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return null;
                      }

                      _formKey.currentState!.save();

                      //print(_name);

                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: email.text, password: pwd.text)
                          .then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const WelcomeScreen())));
                      });
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ))
              ]),
        ),
      ),
    );
  }
}
