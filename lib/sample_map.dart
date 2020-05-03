import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class SampleMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  FlutterMap(
    options:  MapOptions(
      center:  LatLng(51.5, -0.09),
      zoom: 13.0,
    ),
    layers: [
       TileLayerOptions(
        urlTemplate: "https://api.tiles.mapbox.com/v4/"
            "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
        additionalOptions: {
          'accessToken': '<PUT_ACCESS_TOKEN_HERE>',
          'id': 'mapbox.streets',
        },
      ),
       MarkerLayerOptions(
        markers: [
           Marker(
            width: 80.0,
            height: 80.0,
            point:  LatLng(51.5, -0.09),
            builder: (ctx) =>
             Container(
              child: FlutterLogo(),
            ),
          ),
        ],
      ),
    ],
  );
  }
}