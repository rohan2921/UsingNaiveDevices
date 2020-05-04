import 'package:flutter/material.dart';
import 'dart:io';
import '../sample_map.dart';


class ExpandedPlace extends StatefulWidget {
  

  static const routeName='/expanded-place';

  @override
  _ExpandedPlaceState createState() => _ExpandedPlaceState();
}

class _ExpandedPlaceState extends State<ExpandedPlace> {
  var show=false;

  void _showMap(){
        setState(() {
          show=true;
        });
  }

  @override
  Widget build(BuildContext context) {

    final l=ModalRoute.of(context).settings.arguments as List;
      final String title=l[0];
    final File image=l[1];
    final double lat=l[2];
    final double lon=l[3];

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 200,
                width: double.infinity,
                child: Image.file(
                  image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              SizedBox(height: 20),
              Text("Location :",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("Latitude :" + '$lat'),
              SizedBox(height: 5),
              Text("Longitude: " + '$lon'),
              SizedBox(height: 20),
              FlatButton.icon(
                onPressed: _showMap,
                icon: Icon(Icons.map),
                label: Text('See location on Map'),
              ),

              if(show)Container(
                height: 200,
                width: double.infinity,
                  child:SampleMap(lat: lat, long: lon,edit:true)
                ) 
              
            ],
          ),
        ),
      ),
    );
  }
}