import 'dart:developer';

import 'package:asaan_urdu/login.dart';
import 'package:asaan_urdu/speach.dart';
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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var fontsize = TextEditingController();
  SpeechToText _speechToText = SpeechToText();

  bool _speechEnabled = false;

  String _lastWords = '';
  // SpeechRecognition? _speechRecognition;
  // bool _isAvailable = false;
  // bool _isListening = false;

  String resultText = "";

  var urdutext = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(localeId: 'ur-PK', onResult: _onSpeechResult);
    _lastWords = urdutext.text;
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  var siz = 12.1;

  @override
  Widget build(BuildContext context) {
    var kamina = _lastWords;
    urdutext.text = kamina;

    var size = MediaQuery.of(context).size;
    return Scaffold(
      //You should use `Scaffold` if you have `TextField` in body.
      //Otherwise on focus your `TextField` won`t scroll when keyboard popup.
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.height * 0.2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      button(
                          height: 40,
                          onPressed: () {},
                          text: "Create new project",
                          width: 150),
                      button(
                          onPressed: () {},
                          text: "save as pdf",
                          height: 40,
                          width: 150),
                    ],
                  ),

                  Column(
                    children: [
                      button(
                          onPressed: _startListening,
                          text: "listen",
                          height: 40,
                          width: 150),
                      button(
                          onPressed: _stopListening,
                          text: " Stop listen",
                          height: 40,
                          width: 150),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 150,
                        child: TextFormField(
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[0-9.,]+')),
                          ],
                          controller: fontsize,
                          decoration:
                              InputDecoration(hintText: "Enter font size"),
                        ),
                      ),
                      button(
                          onPressed: () {
                            var c = double.parse(fontsize.text);
                            siz = c;
                            print(siz);
                            setState(() {});
                          },
                          height: 40,
                          width: 150,
                          text: "Font Size"),
                    ],
                  ),

                  // Container(
                  //   padding: EdgeInsets.all(16),
                  //   child:
                  // ),
                  // Text(
                  //     // If listening is active show the recognized words

                  //     '${_lastWords}')
                  // If listening isn't active but could be tell the user
                  // how to start it, otherwise indicate that speech
                  // recognition is not yet ready or not supported on
                ],
              ),
            ),

            // docs page
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(18.0),
                    color: Colors.blue,
                    alignment: Alignment.center,
                    child: Text("Header"),
                  ),

                  //Body Container
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            color: Colors.red,
                            height: 200.0,
                            alignment: Alignment.center,
                            child: TextFormField(
                              controller: urdutext,
                              // If listening is active show the recognized words
                              // "$_lastWords",

                              style: TextStyle(fontSize: siz.toDouble()),
                            ),
                          ),
                          // Text("$_lastWords")

                          //TextField nearly at bottom
                        ],
                      ),
                    ),
                  ),

                  //Footer Container
                  //Here you will get unexpected behaviour when keyboard pops-up.
                  //So its better to use `bottomNavigationBar` to avoid this.
                  Container(
                    padding: const EdgeInsets.all(18.0),
                    color: Colors.blue,
                    alignment: Alignment.center,
                    child: Text("Footer"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class button extends StatelessWidget {
  var width;

  var height;

  var onPressed;

  String text;

  button({
    required this.height,
    required this.onPressed,
    required this.text,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ElevatedButton(
          onPressed: onPressed,
          child: Text(text),
          style: ElevatedButton.styleFrom(
              primary: Colors.indigoAccent, //background color of button
              side: BorderSide(
                  width: 2, color: Colors.white), //border width and color
              elevation: 3, //elevation of button
              shape: RoundedRectangleBorder(
                  //to set border radius to button
                  borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.only(
                  bottom: 15,
                  left: 15,
                  right: 15,
                  top: 15) //content padding inside button
              )),
    );
  }
}
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     const appName = 'Custom Themes';

//     return MaterialApp(
//       title: appName,
//       theme: ThemeData(
//         // Define the default brightness and colors.
//         brightness: Brightness.dark,
//         primaryColor: Colors.lightBlue[800],

//         // Define the default font family.
//         fontFamily: 'Georgia',

//         // Define the default `TextTheme`. Use this to specify the default
//         // text styling for headlines, titles, bodies of text, and more.
//         textTheme: const TextTheme(
//           headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
//           headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
//           bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
//         ),
//       ),
//       home: const MyHomePage(
//         title: appName,
//       ),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   final String title;

//   const MyHomePage({super.key, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: Center(
//         child: Container(
//           color: Theme.of(context).colorScheme.secondary,
//           child: Text(
//             'Text with a background color',
//             style: Theme.of(context).textTheme.headline6,
//           ),
//         ),
//       ),
//       floatingActionButton: Theme(
//         data: Theme.of(context).copyWith(splashColor: Colors.yellow),
//         child: FloatingActionButton(
//           onPressed: () {},
//           child: const Icon(Icons.add),
//         ),
//       ),
//     );
//   }
// }
