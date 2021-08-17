import 'package:ebook/Pages/dashboard.dart';
import 'package:ebook/const/const.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Book of Digital Logic',
      theme: ThemeData(primaryColor: primaryColor),
      home: DashboardScreen(),
    );
  }
}
