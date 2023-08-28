import 'package:bottom_navigation_and_drawer/util/webview.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

class MyVenue extends StatelessWidget {
  const MyVenue({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Venue"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                child: Image.asset("assets/images/estoril.jpg"),
              ),
              Container(
                child: Text(
                  textAlign: TextAlign.left,
                  softWrap: true,
                  "Estoril Convention Center",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                decoration: BoxDecoration(),
              ),
              Container(
                child: Text(
                  textAlign: TextAlign.left,
                  softWrap: true,
                  "Centro de Congressos do Estoril",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                ),
                decoration: BoxDecoration(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(
                    textAlign: TextAlign.left,
                    softWrap: true,
                    "Av. Amaral, 2765-192 Estoril, Portugal",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                  decoration: BoxDecoration(),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        child: ElevatedButton(
                      onPressed: () => getMaps(),
                      child: Text("Maps"),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        child: ElevatedButton(
                      onPressed: () => getMaps(),
                      child: Text("Get Directions"),
                    )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getMaps() {
    return MapsLauncher.launchCoordinates(
        38.706944, -9.396111, 'Avenida Amaral. 2765-192 Estoril is here');
  }
}
