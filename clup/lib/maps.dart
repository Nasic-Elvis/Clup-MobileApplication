import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final double lat;
  final double long;
  final String address;
  final String city;

  MapScreen(
      {Key key,
        @required this.lat,
        @required this.long,
        @required this.address,
        @required this.city})
      : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState(lat, long, address, city);
}

class _MapScreenState extends State<MapScreen> {
  double lat;
  double long;
  String address;
  String city;

  _MapScreenState(this.lat, this.long, this.address, this.city);

  CameraPosition _initialCameraPosition;

  GoogleMapController _googleMapController;

  List<Marker> _markers = <Marker>[];

  @override
  void initState() {
    _markers.add(Marker(
        markerId: MarkerId(this.city),
        position: LatLng(lat, long),
        infoWindow: InfoWindow(title: this.address)));
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),*/
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
                bottomRight: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                heightFactor: 0.3,
                widthFactor: 2.5,
                child: GoogleMap(
                  initialCameraPosition: _initialCameraPosition =
                      CameraPosition(
                        target: LatLng(lat, long),
                        zoom: 10.0,
                      ),
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  onMapCreated: (controller) =>
                  _googleMapController = controller,
                  markers: Set<Marker>.of(_markers),
                ),
              ),
            ),
            //),
          ),
        ]);
  }
}
