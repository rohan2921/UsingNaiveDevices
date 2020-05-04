import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
class UserLocation extends StatefulWidget {
  static const routeName='/user-location';
  @override
  _UserLocationState createState() => _UserLocationState();
}

class _UserLocationState extends State<UserLocation> {

  double lat=17.6868;
  double long=83.2185;
  LatLng toSend=LatLng(17.6868, 83.2185);
  @override
  Widget build(BuildContext context) {
    Function fn=ModalRoute.of(context).settings.arguments as Function;
    return Scaffold(
      appBar: AppBar(title:Text('Set Location'),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.save),onPressed: (){
          fn(lat,long);
          Navigator.of(context).pop();
        },)
      ],
      ),
      body: Container(
        child:FlutterMap(
    options:  MapOptions(
      onTap: (user){
        setState(() {
          lat=user.latitude;
          long=user.longitude; 
        });
      },
      center:  LatLng(lat,long),
      zoom: 13.0,
    ),
    layers: [
       TileLayerOptions(
        urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        subdomains: ['a','b','c'],
      ),   
      MarkerLayerOptions(
        markers: [
           Marker(
            width: 80.0,
            height: 80.0,
            point:  LatLng(lat, long),
            builder: (ctx) =>
             Container(
              child:Icon(Icons.location_on,color: Colors.red,)
            ),
          ),
        ],
      )
    ],
  )
      ),
    );
  }
}