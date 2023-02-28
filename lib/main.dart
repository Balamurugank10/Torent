import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:to_rent/authentication/auth_page.dart';
import 'package:to_rent/detail_screen.dart';
import './providers/categories.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Categories(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AuthPage(),
        debugShowCheckedModeBanner: false,
        routes: {
          DetailScreen.routeName: (context) => DetailScreen(),
        },
      ),
    );
  }
}
