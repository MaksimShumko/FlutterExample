import 'package:flutter/material.dart';
import 'package:my_first_app/client_model.dart';
import 'package:my_first_app/database.dart';

class AddClientScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  final clientNameController = TextEditingController();
  final clientCompanyController = TextEditingController();
  final clientEmailController = TextEditingController();

  @override
  void dispose() {
    clientNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text input example"),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(hintText: "Client Name"),
            controller: clientNameController,
          ),
          TextField(
            decoration: InputDecoration(hintText: "Client Company"),
            controller: clientCompanyController,
          ),
          TextField(
            decoration: InputDecoration(hintText: "Client Email"),
            controller: clientEmailController,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.desktop_windows),
          onPressed: () async {
            Client client = new Client(
                id: 1,
                name: clientNameController.text,
                company: clientCompanyController.text,
                email: clientEmailController.text);
            await DBProvider.db.createClient(client);

            Navigator.pop(context, true);
          }),
    );
  }
}
