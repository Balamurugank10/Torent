import 'package:flutter/material.dart';
import './upload_screen.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('dkjkkd'),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const UploadScreen()));
          },
          child: const Text('Rent a New Property'),
        ),
      ],
    ));
  }
}
