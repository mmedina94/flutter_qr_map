import 'package:latlong/latlong.dart';

final _scanType = {'WEB': 'http', 'GEO': 'geo'};

class ScanModel {
  String value;
  String type;

  ScanModel({this.type, this.value}) {
    if (this.value.contains(_scanType['WEB'])) {
      this.type = _scanType['WEB'];
    } else {
      this.type = _scanType['GEO'];
    }
  }

  bool isWeb() => this.type == _scanType['WEB'];

  //geo:-34.894785,-56.152689
  //value.substring(4) --> -34.894785,-56.152689
  //split(',') --> ['-34.894785','-56.152689']
  LatLng getCoordinates() {
    final strCoordinates = value.substring(4).split(',');

    final lat = double.parse(strCoordinates[0]);
    final lng = double.parse(strCoordinates[1]);

    return LatLng(lat, lng);
  }
}
