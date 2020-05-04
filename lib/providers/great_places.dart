import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:locationviewer/db_helper/db_helper.dart';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(
      String title, File imagePlace, double lat, double long) async {
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        image: imagePlace,
        location: PlaceLocation(longitude: long, latitude: lat));
    _items.add(newPlace);
    notifyListeners();
    await DBHelper.insert('userPlaces', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': lat,
      'long': long
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final data = await DBHelper.fetch('userPlaces');
    _items = data
        .map((mp) => Place(
            id: mp['id'],
            title: mp['title'],
            location: PlaceLocation(longitude: mp['long'], latitude: mp['lat']),
            image: File(mp['image'])))
        .toList();
    notifyListeners();
  }
}
