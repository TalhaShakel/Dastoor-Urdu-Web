import 'package:asaan_urdu/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

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

  var footer = TextEditingController();

  var header = TextEditingController();

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
    // _lastWords = urdutext.text;
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
    _lastWords =
        "کی دنیا بھر کی آنکھیں تو ابھی تک جواب نہیں ملی اور جو ڈاکٹر ہے وہ منتھلی 35000 کیا تمہارا میں ان سب میں سے تھوڑا اور میں منتقلی سے رابطہ کیا تم ہارو میرے پاس ایک اللہ پاک کا شکر ہے کہ میں نے اتنی سی عمر میں اتنا کمالیہ";
    var urdutext = TextEditingController(text: _lastWords.toString());
    _lastWords = urdutext.text;
    // var kamina = _lastWords;
    // urdutext.text = kamina;

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
                          onPressed: () {
                            footer.clear();
                            header.clear();
                            urdutext.clear();
                          },
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
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: header,
                      decoration: InputDecoration(labelText: "Header"),
                      style: TextStyle(fontSize: 30),
                    ),
                  ),

                  //Body Container
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              color: Colors.white,
                              // height: 200.0,
                              alignment: Alignment.center,
                              child: TextFormField(
                                maxLines: null,
                                textInputAction: TextInputAction.next,
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
                  ),

                  //Footer Container
                  //Here you will get unexpected behaviour when keyboard pops-up.
                  //So its better to use `bottomNavigationBar` to avoid this.
                  Container(
                    padding: const EdgeInsets.all(18.0),
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: footer,
                      decoration: const InputDecoration(labelText: "Footer"),
                      style: const TextStyle(fontSize: 30),
                    ),
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
