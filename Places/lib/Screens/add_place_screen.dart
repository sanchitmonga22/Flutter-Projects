import 'dart:io';

import 'package:Places/Models/place.dart';
import 'package:Places/Widgets/imageInput.dart';
import 'package:Places/Widgets/locationInput.dart';
import 'package:Places/providers/great_places.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/addPlaceScreen';
  AddPlaceScreen({Key key}) : super(key: key);

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final TextEditingController titleController = TextEditingController();
  File _pickedImage;
  PlaceLocation pickedLocation;

  void selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void selectPlace(double lat, double lng) {
    pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void savePlace() {
    if (titleController.text.isEmpty ||
        _pickedImage == null ||
        pickedLocation == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(titleController.text, _pickedImage, pickedLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a new Place"),
      ),
      body: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Title",
                      ),
                      controller: titleController,
                    ),
                    SizedBox(height: 10),
                    ImageInput(onSelectedImage: selectImage),
                    SizedBox(height: 10),
                    LocationInput(onSelectePlace: selectPlace)
                  ],
                ),
              ),
            )),
            RaisedButton.icon(
                onPressed: savePlace,
                icon: Icon(Icons.add),
                label: Text("Add Place"),
                elevation: 0,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                color: Theme.of(context).accentColor)
          ]),
    );
  }
}
