import 'package:chapter/models/scan_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class MapPage extends StatelessWidget {
  final _accessToken =
      "pk.eyJ1IjoibW1lZGluYWJpb3M5NCIsImEiOiJja2hiOXdkb3oxY3g0MnltbW9qbXkzbHQzIn0.OBEmt24q8xMubZHXxhSvng";

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text('Map Page'),
        ),
        body: _getBody(scan));
  }

  Widget _getBody(ScanModel scan) {
    return FlutterMap(
      options: MapOptions(
        center: scan.getCoordinates(),
        zoom: 15,
      ),
      layers: [
        _getMap(),
        _createMarkers(scan),
      ],
    );
  }

  TileLayerOptions _getMap() {
    return TileLayerOptions(
        urlTemplate:
            'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
        additionalOptions: {
          'accessToken': _accessToken,
          'id': 'mapbox/streets-v11'
        });
  }

  MarkerLayerOptions _createMarkers(ScanModel scan) {
    return MarkerLayerOptions(markers: <Marker>[
      Marker(
        width: 100.0,
        height: 100.0,
        point: scan.getCoordinates(),
        builder: (BuildContext context) => Container(
          child: Icon(
            Icons.location_on,
            size: 45.0,
            color: Colors.red,
          ),
        ),
      )
    ]);
  }
}
