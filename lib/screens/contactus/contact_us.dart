import 'package:bottom_navigation_and_drawer/screens/contactus/contact_us_model.dart';
import 'package:bottom_navigation_and_drawer/util/webview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../drawers/sidemenu.dart';

class MyContactUs extends StatefulWidget {
  const MyContactUs({super.key});

  @override
  State<MyContactUs> createState() => _MyContactUsState();
}

class _MyContactUsState extends State<MyContactUs> {
  final Color titleColor = Color.fromARGB(255, 1, 144, 159);

  List<ContactUsModel> contactList = [];
  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getContacts();

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideMenu(),
        appBar: AppBar(
          title: Text("Contact Us"),
        ),
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                      text: "All General Questions:",
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      // await Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (ctxt) => WebviewComponent(
                      //         title: "secretariat@globalhealth-forum.com",
                      //         webviewUrl: "secretariat@globalhealth-forum.com"),
                      //   ),
                      // );
                      String email = Uri.encodeComponent(
                          "secretariat@globalhealth-forum.com");
                      String subject = "General Questions";
                      String body = "";
                      Uri mail = Uri.parse(
                          "mailto:$email?subject=$subject&body=$body");
                      await launchUrl(mail);
                    },
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.blue),
                        text: "secretariat@globalhealth-forum.com",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                            itemCount: contactList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            color: titleColor),
                                        text: contactList[index].department,
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey),
                                        text: contactList[index].name,
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey),
                                        text: contactList[index].phone,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            })),
                  ),
                ],
              ));
  }

  final dio = Dio();

  Future getContacts() async {
    try {
      final response = await dio.get(
          'https://globalhealth-forum.com/event_app/api/ger_key_contact.php');

      var jsonData = (response.data);
      for (var contact in jsonData) {
        final contacts = ContactUsModel(
            id: contact['id'],
            department: contact['department'],
            name: contact['name'],
            phone: contact['phone']);

        contactList.add(contacts);
        loading = false;
        setState(() {});
      }
      print(contactList.length);
    } catch (e) {
      print(e.toString());
    }
  }
}
