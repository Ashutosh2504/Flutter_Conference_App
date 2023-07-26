import 'package:flutter/material.dart';

class MyGallery extends StatelessWidget {
  const MyGallery({super.key});

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Gallery"),
        ),
        body: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "A petting zoo",
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                TextButton(
                  child: Text(
                    "by Likes",
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () async {
                    // const String _url = "https://www.geeksforgeeks.org";
                    // if (await canLaunch(_url)) {
                    //   launch(_url);
                    // } else {
                    //   throw "Could not launch $_url";
                    // }
                  },
                ),
                // SizedBox(
                //   width: 1,
                // ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.add_a_photo_outlined),
                )
              ],
            ),
            Divider(
              color: Colors.black,
            ),
            Text(
              "Our little brothers have helped us through this difficult year. Shoulder to shoulder, paw to paw. Send in photos of your favourite pets, regardless of biological type or species. Even if they are cacti 🙂",
              textAlign: TextAlign.left,
              softWrap: true,
              //overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
            ),
            Expanded(
              child: GridView.builder(
                //physics: NeverScrollableScrollPhysics(),
                shrinkWrap: false,
                itemCount: 15,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                    // childAspectRatio: MediaQuery.of(context).size.width /
                    //     (MediaQuery.of(context).size.height / 2),
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    crossAxisCount: 2),
                itemBuilder: (_, index) {
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(
                                12.0,
                              )),
                          child: Image.asset(
                            "assets/images/gallery.png",
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 11,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              child: Text("Images"),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.favorite_outline),
                            ),
                            Text("1"),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.comment_bank_outlined),
                            ),
                            Text("0"),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
