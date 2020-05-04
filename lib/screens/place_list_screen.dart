import 'package:flutter/material.dart';
import 'package:locationviewer/providers/great_places.dart';
import 'package:locationviewer/screens/add_place_screen.dart';
import 'package:locationviewer/screens/place_details_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Places'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
                })
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(child: CircularProgressIndicator())
                  : Consumer<GreatPlaces>(
                      builder: (ctx, grt, ch) => grt.items.length <= 0
                          ? ch
                          : ListView.builder(
                              itemBuilder: (ctx, ind) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        FileImage(grt.items[ind].image),
                                  ),
                                  title: Text(grt.items[ind].title),
                                  subtitle: Text(grt
                                          .items[ind].location.latitude
                                          .toStringAsFixed(3) +
                                      grt.items[ind].location.longitude
                                          .toStringAsFixed(3)),
                                  onTap: () {
                                    
                                        Navigator.of(context).pushNamed(ExpandedPlace.routeName,arguments:[grt.items[ind].title,
                                        grt.items[ind].image,
                                        grt.items[ind].location.latitude,
                                        grt.items[ind].location.longitude]);
                                  },
                                );
                              },
                              itemCount: grt.items.length),
                      child: Text(
                        'No places yet Add some',
                        textAlign: TextAlign.center,
                      ),
                    ),
        ));
  }
}
