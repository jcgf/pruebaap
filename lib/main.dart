import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(
    MaterialApp(home: HomePage()),
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map data;
  List procesosData;
  getProcesos() async {
    http.Response response =
        await http.get('http://10.0.2.2:9702/api/utilitys/obtenerprocesos');
    procesosData = json.decode(response.body);
    setState(() {
      procesosData;
    });
  }

  @override
  void initState() {
    super.initState();
    getProcesos();
  }

  Widget build(BuildContext context) {
    int i = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Procesos'),
        backgroundColor: Colors.purple[900],
      ),
      body: ListView.builder(
        itemCount: procesosData == null ? 0 : procesosData.length,
        itemBuilder: (BuildContext context, int index) {
          i = index + 1;
          return Card(
              child: Row(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("$i",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w500))),
              CircleAvatar(
                backgroundImage: NetworkImage(procesosData[index]["imagen"] ==
                        null
                    ? 'https://i.ibb.co/PN1J5qn/iconfinder-crying-emoji-sad-4830812.jpg'
                    : procesosData[index]["imagen"]),
              ),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "  ${procesosData[index]["codigo"]} ${procesosData[index]["nombre"]}",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
                  ))
            ],
          ));
        },
      ),
    );
  }
}
