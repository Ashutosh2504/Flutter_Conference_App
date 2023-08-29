import 'dart:convert';
import 'package:bottom_navigation_and_drawer/screens/login/compare_otp_model.dart';
import 'package:bottom_navigation_and_drawer/screens/participants/participants_model.dart';
import 'package:bottom_navigation_and_drawer/util/routes.dart';
import 'package:dio/dio.dart';
import 'package:quickalert/quickalert.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCompareOTP extends StatefulWidget {
  const MyCompareOTP({super.key});

  @override
  State<MyCompareOTP> createState() => _MyCompareOTPState();
}

class _MyCompareOTPState extends State<MyCompareOTP> {
  final Color color = Color.fromARGB(255, 15, 158, 174);

  String _name = "";
  String _otp = "";
  bool changeBtn = false;
  final dio = Dio();

//ashup953@gmail.com
  Future getOtp(String otp) async {
    setState(() {
      changeBtn = true;
    });
    if (otp.isNotEmpty) {
      final response = await dio.get(
          'https://globalhealth-forum.com/event_app/api/otp.php?otp=${otp}');
      if (response.statusCode == 200) {
        print(response.data);
        var jsonData = (response.data);
        var userDetails = CompareOtpModel.fromJson(jsonData);

        var prefs = await SharedPreferences.getInstance();
        prefs.setString("user_id", userDetails.user.id);
        prefs.setString("email", userDetails.user.email);
        prefs.setString("name", userDetails.user.name);
        prefs.setString("name", userDetails.user.name);
        prefs.setString("logged_in", "true");

        setState(() {
          changeBtn = false;
        });
        Navigator.pushNamed(context, MyRoutes.homeRoute);
      }
    } else {
      showAlert();
      setState(() {
        changeBtn = false;
      });
    }
  }

  // Future getSpeakers() async {
  //   final response = await dio
  //       .get('https://globalhealth-forum.com/event_app/api/get_speaker.php');
  //   var jsonData = jsonDecode(response.data);
  //   for (var items in jsonData) {
  //     final speakers = SpeakerModel(
  //         id: items['id'],
  //         name: items['name'],
  //         email: items['email'],
  //         mobile: items['mobile'],
  //         designation: items['designation'],
  //         institute: items['institute'],
  //         information: items['information'],
  //         city: items['city'],
  //         country: items['country'],
  //         date: items['date'],
  //         photo: items['photo'],
  //         status: items['status']);

  //     speakersList.add(speakers);
  //   }
  // }

  void showAlert() {
    QuickAlert.show(
        confirmBtnColor: color,
        context: context,
        text: "Please enter correct OTP !",
        type: QuickAlertType.warning);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter OTP from your mail",
                  label: Text("OTP"),
                ),
                onChanged: (value) {
                  _otp = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                color: color,
                borderRadius: BorderRadius.circular(changeBtn ? 50 : 8),
                child: InkWell(
                  onTap: () {
                    getOtp(_otp);
                    setState(() {});
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
                            "Login",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
