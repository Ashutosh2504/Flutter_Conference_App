import 'package:flutter/material.dart';

class MyHomeGridHorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  border: Border.all(color: Colors.lightBlueAccent)),
              height: 100,
              child: Image.asset(
                "assets/images/dr2.png",
              ),
            ),
          ),
        ),
        Text("Sessions"),
      ],
    );
  }
}
