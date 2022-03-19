import 'dart:io';

import 'package:band_names/src/models/band_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  get itemBuilder => null;
  List<Band> bands = [
    Band(id: '1', name: 'Libido', votes: 5),
    Band(id: '2', name: 'Mar de copas', votes: 2),
    Band(id: '3', name: 'Amen', votes: 3),
    Band(id: '4', name: 'zen', votes: 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BandNames',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) =>
            _bandTile(bands, index),
      ),
      floatingActionButton: IconButton(
        icon: Icon(Icons.add),
        onPressed: addNewBand,
      ),
    );
  }

  Widget _bandTile(List<Band> bands, int index) {
    return Dismissible(
      key: Key(bands[index].id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print('direction: $direction');
        print('id: ${bands[index].id}');
        //llamar el delete del backend
      },
      background: Container(
        padding: EdgeInsets.only(left: 10),
        color: Colors.red,
        child: Align(
          child: Text('Delete band', style: TextStyle(color: Colors.white)),
          alignment: Alignment.centerLeft,
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(bands[index].name.substring(0, 2)),
          backgroundColor: Colors.blue[200],
        ),
        title: Text(bands[index].name),
        trailing: Text('${bands[index].votes}', style: TextStyle(fontSize: 20)),
        onTap: () {
          print('${bands[index].name}');
        },
      ),
    );
  }

  addNewBand() {
    TextEditingController _nameController = new TextEditingController();

    if (Platform.isAndroid) {
      //for android
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New band name'),
            content: TextField(
              controller: _nameController,
            ),
            actions: [
              MaterialButton(
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.blue, fontSize: 18),
                ),
                elevation: 1,
                onPressed: () {
                  addNameToList(_nameController.text);
                },
              )
            ],
          );
        },
      );
    }
//for Ios
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('New band name'),
          content: CupertinoTextField(
            controller: _nameController,
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text(
                'Add',
                style: TextStyle(color: Colors.blue, fontSize: 18),
              ),
              onPressed: () => addNameToList(_nameController.text),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text(
                'Dismiss',
                style: TextStyle(color: Colors.blue, fontSize: 18),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void addNameToList(String name) {
    print(name);
    if (name.length > 1) {
      this.bands.add(new Band(id: '${bands.length + 1}', name: name, votes: 3));
      refresh();
    }
    Navigator.pop(context);
  }

  void refresh() {
    setState(() {});
  }
}
