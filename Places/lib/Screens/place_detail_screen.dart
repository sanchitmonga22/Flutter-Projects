import 'package:Places/Screens/mapsScreen.dart';
import 'package:Places/providers/great_places.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = "/PlaceDetails";
  const PlaceDetailScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<GreatPlaces>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(children: [
        Container(
          height: 250,
          width: double.infinity,
          child: Image.file(
            selectedPlace.image,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        SizedBox(height: 10),
        Text(
          selectedPlace.location.address,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
        SizedBox(height: 10),
        FlatButton(
          child: Text("View on Map"),
          textColor: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => MapsScreen(
                initialLocation: selectedPlace.location,
              ),
            ));
          },
        ),
      ]),
    );
  }
}
