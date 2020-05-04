import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class SampleMap extends StatelessWidget {
  final lat;
  final long;
  final bool edit;
  SampleMap({@required this.lat,@required this.long,this.edit=false});
  @override
  Widget build(BuildContext context) {
    return  FlutterMap(
    options:  MapOptions(
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
  );
  }
}