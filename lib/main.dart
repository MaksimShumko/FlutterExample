import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_first_app/add_client_screen.dart';
import 'package:my_first_app/client_model.dart';
import 'package:my_first_app/database.dart';
import 'package:my_first_app/list_element.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ClientsList()
    );
  }
}

class ClientsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ClientListState();
}

class _ClientListState extends State<ClientsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Some title"),
        ),
        body: FutureBuilder<List<Client>>(
          future: fetchObject(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListElement(snapshot.data[index]);
                })
                : Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: _MyFab()
    );
  }
}

class _MyFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddClientScreen()));
        });
  }
}

Future<List<Client>> fetchObjects() async {
  final response =
      await http.get('http://www.mocky.io/v2/5c4175e20f00004b3fe7b7f2');
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<Client>((json) => Client.fromJson(json)).toList();
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

Future<List<Client>> fetchObject() async {
  return await DBProvider.db.getAllClients();
}
