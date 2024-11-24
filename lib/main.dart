import 'package:ebook/Splash%20Screen.dart';
import 'package:ebook/admin/dashboard.dart';
import 'package:ebook/homepage.dart';
import 'package:ebook/homepage/seeall.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBRFDlcRRxjmGBDIecjaeGSFK1F6K4NmTg",
          appId: "1:79415813615:android:16e8089fefc5287fa9421a",
          messagingSenderId: "79415813615",
          projectId: "decors-4ff7f",
          storageBucket: 'gs://decors-4ff7f.appspot.com'));
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // colorSchemeSeed: Color(0xfdaaa63),
        // brightness: Brightness.dark,
        // primaryColor: Colors.amber[100],
        // secondaryHeaderColor: Colors.blue[50],

        useMaterial3: true,
      ),
      home: splash()));
}
//HomePage
////splash
// genCreate
//UmrahCalculatorApp
//SplashScreen
//MyApp 