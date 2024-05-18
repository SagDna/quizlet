import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizlet/create_sets.dart';
import 'package:quizlet/home_page.dart';

import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyC4GjRVQG1lc67qzGdmR64oTpQndGGl6_M",
              appId: "1:632738475834:android:d4bf706b374a8303a56a03",
              databaseURL: "https://quizlet-1fa8e-default-rtdb.asia-southeast1.firebasedatabase.app",
              messagingSenderId: "632738475834",
              projectId: "quizlet-1fa8e"))
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  HomePage(),
    );
  }
}
