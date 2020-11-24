import 'dart:async';

import 'package:chapter/models/scan_model.dart';

class ScansBloc {
  final _scans = List<ScanModel>();

  static final ScansBloc _singleton = new ScansBloc._internal();
  final StreamController _streamController =
      StreamController<List<ScanModel>>.broadcast();
  Stream<List<ScanModel>> get stream => _streamController.stream;

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    _loadStream();
  }

  _loadStream() {
    _streamController.sink.add(_scans);
  }

  addScan(ScanModel scan) {
    _scans.add(scan);
    _loadStream();
  }

  removeScan(int position) {
    _scans.removeAt(position);
    _loadStream();
  }

  removeAll() {
    _scans.clear();
    _loadStream();
  }

  dispose() {
    _streamController?.close();
  }
}
