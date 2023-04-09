import 'package:flutter/material.dart';
import '../screens/forgot_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../owner/delete_prop.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  final userName = FirebaseAuth.instance.currentUser!.displayName;
  final userEmail = FirebaseAuth.instance.currentUser!.email;
  final userDp = FirebaseAuth.instance.currentUser!.photoURL;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.29,
          decoration: const BoxDecoration(color: Colors.blue),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            CircleAvatar(
              radius: 52,
              backgroundImage: NetworkImage('$userDp'
                  // 'https://track2traininginstitute.files.wordpress.com/2021/07/apj.jpg'
                  ),
            ),
            const SizedBox(height: 20),
            Text(
              ' $userName',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              '$userEmail',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 20),
          ]),
        ),
        ListTile(
          leading: const Icon(
            Icons.insert_emoticon,
            size: 26,
          ),
          title: const Text(
            'Your Properties',
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => DeleteProp()));
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.person_add_alt_rounded,
            size: 26,
          ),
          title: const Text(
            'Edit Profile',
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(
            Icons.lock_outline,
            size: 26,
          ),
          title: const Text(
            'Change Password',
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ForgotPassword()));
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.logout_outlined,
            size: 26,
          ),
          title: const Text(
            'Logout',
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          onTap: () {
            signOut();
          },
        ),
        const Divider(
          height: 5,
          color: Colors.black,
          // height: 15,
          thickness: 1,
          indent: 20,
          endIndent: 20,
          //color:Colors.black,
        ),
        ListTile(
          leading: const Icon(
            Icons.privacy_tip_outlined,
            size: 26,
          ),
          title: const Text(
            'Privacy Policy',
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(
            Icons.edit_note_sharp,
            size: 26,
          ),
          title: const Text(
            'Terms and Conditions',
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(
            Icons.email_outlined,
            size: 26,
          ),
          title: const Text(
            'Contact Us',
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(
            Icons.info_outline_rounded,
            size: 26,
          ),
          title: const Text(
            'About Us',
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          onTap: () {},
        ),
        const Divider(
          height: 5,
          color: Colors.black,
          // height: 15,
          thickness: 1,
          indent: 20,
          endIndent: 20,
          //color:Colors.black,
        ),
        ListTile(
          leading: const Icon(
            Icons.settings,
            size: 26,
          ),
          title: const Text(
            'Settings',
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          onTap: () {},
        ),
      ]),
    );
  }
}
