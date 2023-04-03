import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../pages/favorite_page.dart';
import '../owner/post_screen.dart';
import '../owner/upload_screen.dart';
import '../pages/overview_page.dart';
import '../pages/profile_page.dart';
import '../drawer/main_drawer.dart';
import '../a.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  final screens = [
    const A(),
    const FavoriteScreen(),
    const UploadScreen(),
    const A(),
  ];

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToRent"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_none))
        ],
      ),
      drawer: const MainDrawer(),
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.shifting,
        currentIndex: index,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        onTap: (value) => setState(() => index = value),
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.home_outlined),
              label: 'Home'),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.favorite_border_outlined),
              label: 'Favorite'),
          BottomNavigationBarItem(
              icon: const Icon(Icons.post_add_rounded), label: user?.email),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_sharp), label: 'Profile'),
        ],
      ),
    );
  }
}
