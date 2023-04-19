import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../pages/favorite_page.dart';
import '../owner/upload_screen.dart';
import '../drawer/main_drawer.dart';
import '../main_screen.dart';
import '../drawer/settings.dart';

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
    const HomeScreen(),
    const FavoriteScreen(),
    const UploadScreen(),
  ];

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: index == 0
          ? null
          : AppBar(
              title: const Text("To-Rent"),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Settings()));
                    },
                    icon: const Icon(Icons.settings))
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
          const BottomNavigationBarItem(
              icon: Icon(Icons.post_add_rounded), label: 'Post'),
        ],
      ),
    );
  }
}
