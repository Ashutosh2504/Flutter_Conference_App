import 'package:bottom_navigation_and_drawer/util/routes.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _name = "";
  bool changeBtn = false;

  final _formKey = GlobalKey<FormState>();

  moveToHome(BuildContext context) async {
    setState(() {
      changeBtn = true;
    });
    await Future.delayed(Duration(seconds: 1));
    await Navigator.pushNamed(context, MyRoutes.homeRoute);
    setState(() {
      changeBtn = false;
    });
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
                Image.asset(
                  'assets/images/login.png',
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  // creates empty box of specified height and we can add child also in it.
                  height: 20,
                ),
                Text(
                  'Welcome $_name',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                SizedBox(
                  // creates empty box of specified height and we can add child also in it.
                  height: 20,
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
                              hintText: "Enter username",
                              label: Text("Username"),
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
                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Enter password",
                              label: Text("Password"),
                            ),
                            // validator: (value ) {
                            //   if (value.length<6) {
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
                            color: Colors.blue[900],
                            borderRadius:
                                BorderRadius.circular(changeBtn ? 50 : 8),
                            child: InkWell(
                              onTap: () => moveToHome(context),
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
