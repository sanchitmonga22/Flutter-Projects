import 'package:Places/Screens/mapsScreen.dart';
import 'package:Places/helpers/locationHelper.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  LocationInput({Key key}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String previewImageUrl;

  Future<void> getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: locData.latitude, longitude: locData.longitude);
    setState(() {
      previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) {
        return MapsScreen(
          isSelecting: true,
        );
      },
    ));
    if (selectedLocation == null) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: previewImageUrl == null
              ? Text(
                  "No Location chosen",
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
                icon: Icon(Icons.location_on),
                label: Text(
                  'Current location',
                ),
                textColor: Theme.of(context).primaryColor,
                onPressed: getCurrentUserLocation),
            FlatButton.icon(
              icon: Icon(Icons.map),
              label: Text(
                'Select on Map',
              ),
              textColor: Theme.of(context).primaryColor,
              onPressed: selectOnMap,
            )
          ],
        )
      ],
    );
  }
}
