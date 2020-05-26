import 'package:Places/Models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  const MapsScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: 37.422, longitude: -122),
      this.isSelecting = false});

  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  LatLng pickedLocation;
  void selectLocation(LatLng position) {
    setState(() {
      pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MAP"),
        actions: [
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(pickedLocation);
                    },
            )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialLocation.latitude,
              widget.initialLocation.longitude),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? selectLocation : null,
        markers: (pickedLocation == null && widget.isSelecting)
            ? null
            : {
                Marker(
                    markerId: MarkerId('m1'),
                    position: pickedLocation ??
                        LatLng(widget.initialLocation.latitude,
                            widget.initialLocation.longitude))
              },
      ),
    );
  }
}
