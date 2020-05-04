import 'package:flutter/material.dart';
import 'package:locationviewer/providers/great_places.dart';
import 'package:locationviewer/sample_map.dart';
import 'package:locationviewer/screens/add_place_screen.dart';
import 'package:locationviewer/screens/place_details_screen.dart';
import 'package:locationviewer/screens/place_list_screen.dart';
import 'package:locationviewer/screens/user_location.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
        
          child: MaterialApp(
        title: 'Places',
        theme: ThemeData(
          accentColor: Colors.blueAccent,
          primarySwatch: Colors.blue,
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName:(ctx)=>AddPlaceScreen(),
          UserLocation.routeName:(ctx)=>UserLocation(),
          ExpandedPlace.routeName:(ctx)=>ExpandedPlace()
        },
      ),
    );
  }
}

