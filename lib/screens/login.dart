import 'package:asaan_urdu/main.dart';
import 'package:asaan_urdu/screens/home.dart';
import 'package:asaan_urdu/screens/sigin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class login extends StatelessWidget {
  login({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          gradient: LinearGradient(
              colors: [Color.fromARGB(255, 19, 36, 133), Colors.blueAccent]),
        ),
        child: Center(
          child: Container(
            height: size.height * 0.6,
            width: size.height * 0.5,
            child: Card(
              // color: Colors.blue,
              shadowColor: Colors.black,
              elevation: 50,
              margin: EdgeInsets.all(20),
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.white)),
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              'Dastoor ',
                              style: TextStyle(
                                fontSize: 35,
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo,
                                // fontWeight: FontWeight.w500,
                                // fontSize: 30
                              ),
                            )),
                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              'Log in',
                              style: TextStyle(
                                fontSize: 25,
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold,
                                // fontSize: 20
                              ),
                            )),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'enter a valid eamil';
                              } else if (!value.contains("@")) {
                                return 'enter a valid eamil';
                              }
                              return null;
                            },
                            controller: nameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'User Name',
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Password";
                              } else if (value.length < 6) {
                                return "Password must be atleast 6 characters long";
                              } else {
                                return null;
                              }
                            },
                            obscureText: true,
                            controller: passwordController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            //forgot password screen
                          },
                          child: const Text(
                            'Forgot Password',
                          ),
                        ),
                        Container(
                            height: 50,
                            padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.indigo,
                                  // padding: EdgeInsets.symmetric(
                                  //     horizontal: 50, vertical: 20),
                                  textStyle: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.bold)),
                              child: const Text('Login'),
                              onPressed: () {
                                _formKey.currentState?.validate();
                                // Get.to(MyHomePage());
                                print("textFieldsValue");
                                print(nameController.text);
                                print(passwordController.text);
                              },
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 68.0),
                          child: Row(
                            children: <Widget>[
                              const Text('Does not have account?'),
                              TextButton(
                                child: const Text(
                                  'Sign in',
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  //signup screen
                                  Get.to(sign());
                                },
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
