import 'package:flutter/material.dart';
import '../services/firebase_services.dart';
import '../screens/welcome_screen.dart';

class GmailLogin extends StatefulWidget {
  const GmailLogin({super.key});

  @override
  _GmailLoginState createState() => _GmailLoginState();
}

class _GmailLoginState extends State<GmailLogin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //width: MediaQuery.of(context).size.width,
      //height: 56,
      child: ElevatedButton(
        onPressed: () {
          FirebaseServices().signInWithGoogle();

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()));
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.white;
            }
            return Colors.black54;
          }),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            linkWidget("assets/images/google_logo.png"),
            const SizedBox(width: 10),
            const Text(
              'Login with Gmail',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

Image linkWidget(String ImageName) {
  return Image.asset(
    ImageName,
    fit: BoxFit.fitWidth,
    width: 40,
    height: 35,
  );
}
