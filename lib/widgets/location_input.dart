import 'package:flutter/material.dart';

import 'package:location/location.dart';
import 'package:locationviewer/sample_map.dart';
import 'package:locationviewer/screens/user_location.dart';

class LocationInput extends StatefulWidget {
  final Function rec;
  LocationInput(this.rec);
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  double lat = 0;
  double long = 0;

  void setLatLong(double la,double lon){
    lat=la;
    long=lon;
    print(la);
    print(lon);
    widget.rec(lat,long);
  }

  Future<void> _currentLocation() async {
    final locationData = await Location().getLocation();
    lat = (locationData.latitude);
    long = (locationData.longitude);
    print(lat);
    print(long);
    widget.rec(lat,long);
    setState(() {});
  }

  
  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: Colors.deepPurple)),
            alignment: Alignment.center,
            height: 270,
            width: double.infinity,
            child: lat == 0 && long == 0
                ? Center(child: Text('Set current location'))
                : SampleMap(lat: lat, long: long, edit: false)),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
                onPressed: _currentLocation,
                icon: Icon(Icons.location_on),
                label: Text('Current Location')),
            FlatButton.icon(
                onPressed: ()async{
                 await Navigator.of(context).pushNamed(UserLocation.routeName,arguments: setLatLong);
                  setState(() {
                    print(lat);
                      print(long);
                  });
                },
                icon: Icon(Icons.map),
                label: Text('Set location'))
          ],
        )
      ],
    );
  }
}
