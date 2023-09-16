import 'package:bottom_navigation_and_drawer/screens/drawers/sidemenu.dart';
import 'package:bottom_navigation_and_drawer/screens/faq/faq_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MyFaq extends StatefulWidget {
  const MyFaq({super.key});

  @override
  State<MyFaq> createState() => _MyFaqState();
}

class _MyFaqState extends State<MyFaq> {
  List<FaqModel> faqList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text("FAQ"),
      ),
      body: FutureBuilder(
          future: getFaq(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: faqList.length,
                    itemBuilder: (context, index) {
                      final question = faqList[index].que;
                      final answer = faqList[index].ans;
                      return ExpansionTile(
                        title: Text(
                          question!,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(answer!), //make it left aligned
                          ),
                        ],
                      );
                    },
                  ));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  final dio = Dio();
  Future getFaq() async {
    try {
      final response = await dio
          .get('https://globalhealth-forum.com/event_app/api/get_faq.php');

      var jsonData = (response.data);
      for (var items in jsonData) {
        final gallery = FaqModel(
            id: items['id'],
            que: items['que'],
            ans: items['ans'],
            status: items['status']);

        faqList.add(gallery);
      }
      print(faqList.length);
    } catch (e) {
      print(e.toString());
    }
  }
}
