import 'dart:developer';

import 'package:asaan_urdu/screens/login.dart';
import 'package:asaan_urdu/screens/home.dart';
import 'package:asaan_urdu/screens/textbold.dart';
import 'package:asaan_urdu/speach.dart';
import 'package:asaan_urdu/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dastoor",
      theme: ThemeData(
        // Define the default brightness and colors.
        // brightness: Brightness.dark,
        // primaryColor: Colors.lightBlue[800],

        // // Define the default font family.
        // fontFamily: 'Georgia',
        buttonColor: Colors.blue[800],
        // brightness: Brightness.,
        // primarySwatch: Colors.blue,
        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      themeMode: ThemeMode.dark,
      home: MyHomePage(),
    );
  }
}
