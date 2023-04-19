import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:to_rent/authentication/auth_page.dart';
import 'package:to_rent/detail_screen.dart';
import 'wastages/providers/categories.dart';
import 'package:provider/provider.dart';
import './notification_services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationService().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Categories(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: const AuthPage(),
        debugShowCheckedModeBanner: false,
        routes: {
          // DetailScreen.routeName: (context) => const DetailScreen(),
          "detail": (context) => const DetailScreen(),
        },
      ),
    );
  }
}
