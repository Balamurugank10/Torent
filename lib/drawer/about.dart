import 'package:flutter/material.dart';
import '../reusable_widgets/reusable_widgets.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(title: const Text('About Us')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Center(
              child: Column(
            children: [
              const SizedBox(height: 60),
              logoWidget("assets/images/logo.png"),
              const SizedBox(height: 10),
              const Text(
                'ToRent Service',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.yellowAccent,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 7),
              const Text(
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 10,
                'This application is basically used to rent out your properties to other people. In this app, the property owner will place their properties on the app and we will add the details of the properties. The tenants can search properties based on their preferences, view property details, and make reservations. The primary objective of the rental management system is to simplify the rental process for both owners and tenants while providing a secure and efficient platform for managing rental properties.',
                style: TextStyle(
                  color: Colors.yellow,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              const Text(
                '©2023 ToRent Service',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          )),
        ));
  }
}
