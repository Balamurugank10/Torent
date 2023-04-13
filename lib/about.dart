import 'package:flutter/material.dart';
import './reusable_widgets/reusable_widgets.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('About Us')),
      body: Center(
          child: Column(
        children: [
          logoWidget("assets/images/logo.png"),
          const Text(
            'To Rent',
            style: TextStyle(
                fontSize: 30,
                color: Colors.yellowAccent,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 7),
          const Text(
            'It is anjknb djsd jkjkjahdjhd dghj dghj jzdg ghjdgjhdggjd zdgjgdjgdj',
            style: TextStyle(
              color: Colors.yellow,
            ),
          ),
        ],
      )),
    );
  }
}
