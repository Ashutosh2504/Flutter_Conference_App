import 'package:flutter/material.dart';

class MyAgenda extends StatefulWidget {
  const MyAgenda({super.key});

  @override
  State<MyAgenda> createState() => _MyAgendaState();
}

class _MyAgendaState extends State<MyAgenda> {
  List<Map<String, dynamic>> _allAgendas = [
    {"id": 1, "name": "Gregory Mole", "place": "Kolkata"},
    {"id": 2, "name": "Himanshu Mole", "place": "Kolkata"},
    {"id": 3, "name": "Ashu Mole", "place": "Kolkata"},
    {"id": 4, "name": "Messi Mole", "place": "Kolkata"},
    {"id": 5, "name": "Gregory Mole", "place": "Kolkata"},
    {"id": 6, "name": "Gregory Mole", "place": "Kolkata"},
  ];

  List<Map<String, dynamic>> _foundAgendas = [];

  @override
  void initState() {
    _foundAgendas = _allAgendas;

    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> _results = [];
    if (enteredKeyword.isEmpty) {
      _results = _allAgendas;
    } else {
      _results = _allAgendas
          .where((agenda) => agenda["name"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundAgendas = _results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Agenda",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                labelText: "Select Hall",
                suffixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _foundAgendas.length,
                itemBuilder: (context, index) => Card(
                  key: ValueKey(_foundAgendas[index]["id"]),
                  color: Colors.blueGrey[50],
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey),
                                  text: "10:30 - 10:35 ",
                                ),
                              ),
                              Text(
                                "Places: ${_foundAgendas[index]["id"]}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.blueGrey),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Colors.lightBlue)),
                                child: const Text(
                                  "Book",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                        Text(
                          "Welcome to ${_foundAgendas[index]["name"]}'s speech hall ",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.normal,
                              color: Colors.pinkAccent),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.place,
                              color: Colors.blueAccent,
                            ),
                            Text(
                              "Hall ${_foundAgendas[index]["id"]}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.blueGrey),
                            ),
                          ],
                        ),
                        Text(
                          "Speakers",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.normal,
                              color: Colors.blueGrey),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            onTap: () {
                              print(_foundAgendas.toString());
                            },
                            leading: CircleAvatar(
                              radius: 25,
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/images/dr2.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            title: Text(
                              _foundAgendas[index]["name"],
                              style: TextStyle(
                                  color: Colors.pinkAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "MBBS (Ortho)",
                                  // _foundAgendas[index]["place"],
                                  style: TextStyle(color: Colors.blueGrey),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  _foundAgendas[index]["place"],
                                  style: TextStyle(color: Colors.blueGrey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
