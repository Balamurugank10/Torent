import 'package:flutter/material.dart';
import './reusable_widgets/reusable_widgets.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              logoWidget("assets/images/logo.png"),
              const SizedBox(height: 30),
              const Text(
                'To Rent',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.yellowAccent,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 7),
              const Text(
                'We provide the best platform to rent a property.',
                style: TextStyle(
                  color: Colors.yellow,
                ),
              ),
              // SizedBox(height: 12),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Icon(
              //       Icons.facebook,
              //       color: Colors.white,
              //       size: 44,
              //     ),
              //     Icon(
              //       Icons.ac_unit,
              //       color: Colors.white,
              //     ),
              //   ],
              // ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              const Text(
                'For Further Details',
                style: TextStyle(color: Colors.lightBlue, fontSize: 23),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.call,
                    color: Colors.green,
                  ),
                  Text(
                    '   +91-8825772826',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.call,
                    color: Colors.green,
                  ),
                  Text(
                    '   +91-7373131108',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.mail,
                    color: Colors.green,
                  ),
                  Text(
                    '   torentservice@gmail.com',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              const Text(
                '©2023 ToRent Service',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ));
  }
}
