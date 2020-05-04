import 'dart:io';

import 'package:flutter/material.dart';
import 'package:locationviewer/providers/great_places.dart';
import 'package:locationviewer/widgets/location_input.dart';
import 'package:provider/provider.dart';
import '../widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place-screen';
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  double lat;
  double long;
  File _pickedImage;
  void _addImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void setLatLong(double la, double lon) {
    lat = la;
    long = lon;
  }

  void _savePlace() {
    print('in save');
    print(lat);
    print(long);
    if (_pickedImage == null || _titleController == null ||lat==null || long == null ) return;
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage, lat, long);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add a place')),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    SizedBox(height: 10),
                    ImageInput(_addImage),
                    SizedBox(height: 10),
                    LocationInput(setLatLong)
                  ]),
                ),
              ),
            ),
            RaisedButton.icon(
              onPressed: _savePlace,
              icon: Icon(Icons.add),
              label: Text('Add a place'),
              elevation: 0,
            )
          ]),
    );
  }
}
