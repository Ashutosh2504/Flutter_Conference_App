import 'package:bottom_navigation_and_drawer/screens/sponser/patronage_model.dart';
import 'package:bottom_navigation_and_drawer/util/webview.dart';
import 'package:flutter/material.dart';

class SponserContent extends StatefulWidget {
  const SponserContent({super.key, required this.sponser});

  final Patronage sponser;
  @override
  State<SponserContent> createState() => _SponserContentState();
}

class _SponserContentState extends State<SponserContent> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.sponser.category,
          style: TextStyle(fontWeight: FontWeight.bold),
          softWrap: true,
        ),
      ),
      body: Container(
        width: queryData.size.width,
        height: queryData.size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 50,
              child: ClipRRect(
                child: Image.network(
                  widget.sponser.logo,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            RichText(
              textAlign: TextAlign.left,
              softWrap: true,
              text: TextSpan(
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent),
                text: widget.sponser.name,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("URL: "),
                  Container(
                    child: InkWell(
                      onTap: () => {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctxt) => WebviewComponent(
                                title: widget.sponser.name,
                                webviewUrl: widget.sponser.companyUrl),
                          ),
                        ),
                      },
                      child: Text(
                        widget.sponser.companyUrl,
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            semanticLabel: "Info",
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Info:",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      Text(
                        widget.sponser.comInfo,
                        textAlign: TextAlign.start,
                        softWrap: true,
                        //overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Tags: "),
                  Container(
                    child: Text(
                      widget.sponser.tags,
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 18,
                      ),
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
