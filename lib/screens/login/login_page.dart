import 'dart:convert';

import 'package:bottom_navigation_and_drawer/screens/login/sendtp_model.dart';
import 'package:bottom_navigation_and_drawer/util/routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Color color = Color.fromARGB(255, 15, 158, 174);
  

  String _name = "";
  bool changeBtn = false;

  final _formKey = GlobalKey<FormState>();
  final dio = Dio();

  moveToHome(BuildContext context) async {
    setState(() {
      changeBtn = true;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    await Future.delayed(Duration(seconds: 1));
    await Navigator.pushNamed(context, MyRoutes.homeRoute);
    setState(() {
      changeBtn = false;
    });
  }

//ashup953@gmail.com
  Future getOtp(String name) async {
    setState(() {
      changeBtn = true;
    });
    var response = await http.get(
      Uri.parse(
          "https://globalhealth-forum.com/event_app/api/login.php?email=${name}"),
    );

    if (response.statusCode == 200) {
      print(response.body);
      var jsonData = (response.body);

      setState(() {
        changeBtn = false;
      });
      Navigator.pushNamed(context, MyRoutes.compareOTP);
    } else {
      showAlert();
      setState(() {
        changeBtn = false;
      });
    }
  }

  void showAlert() {
    QuickAlert.show(
        confirmBtnColor: color,
        context: context,
        text: "Please enter correct email !",
        type: QuickAlertType.warning);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/login.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  'Welcome ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                Text(
                  '$_name',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 32.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Enter your mail",
                              label: Text("Email"),
                            ),
                            onChanged: (value) {
                              _name = value;
                              setState(() {});
                            },
                            // validator: (value) {
                            //   if (value.isEmpty) {
                            //     return "Username cannot be empty";
                            //   }
                            //   return null;
                            // },
                          ),
                          SizedBox(
                            // creates empty box of specified height and we can add child also in it.
                            height: 40,
                          ),
                          Material(
                            color: color,
                            borderRadius:
                                BorderRadius.circular(changeBtn ? 50 : 8),
                            child: InkWell(
                              onTap: () {
                                getOtp(_name);
                              },
                              child: AnimatedContainer(
                                duration: Duration(seconds: 1),
                                alignment: Alignment.center,
                                width: changeBtn ? 60 : 150,
                                height: 50,
                                child: changeBtn
                                    ? Icon(
                                        Icons.done,
                                        color: Colors.white,
                                      )
                                    : Text(
                                        "Get OTP",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
