import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../reusable_widgets/profile_widget.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final userName = FirebaseAuth.instance.currentUser!.displayName;
  final userEmail = FirebaseAuth.instance.currentUser!.email;
  final userDp = FirebaseAuth.instance.currentUser!.photoURL;
  var imgUrl =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Center(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 20,
                ),
                ProfileWidget(
                    imagePath: '$imgUrl',
                    onClicked: () async {
                      print(userDp);
                      print(userEmail);
                      print(userName);
                    }),
                const SizedBox(
                  height: 24,
                ),
                buildName('$userName', '$userEmail', '8898'),
              ],
            ),
          )),
    );
  }

  Widget buildName(String name, String email, String mobile) => Column(
        children: [
          TextField(
            decoration: InputDecoration(
                labelText: "Full Name",
                hintText: "$userName",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
          const SizedBox(height: 15),
          TextField(
            decoration: InputDecoration(
                labelText: "E-mail",
                hintText: "$userEmail",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
          const SizedBox(height: 15),
          const TextField(
            decoration: InputDecoration(
                labelText: "Mobile No",
                hintText: "8825772826",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
          const SizedBox(height: 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              OutlinedButton(
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(20)),
                  // padding: EdgeInsets.symmetric(horizontal: 50),
                  onPressed: () {},
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(
                        fontSize: 14, letterSpacing: 2.2, color: Colors.black),
                  )),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'SAVE',
                    style: TextStyle(
                        color: Colors.white, letterSpacing: 2.2, fontSize: 14),
                  ))
            ],
          ),
        ],
      );
}
