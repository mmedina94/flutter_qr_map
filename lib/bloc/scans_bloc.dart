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
    loadStream();
  }

  loadStream() {
    _streamController.sink.add(_scans);
  }

  addScan(ScanModel scan) {
    _scans.add(scan);
    loadStream();
  }

  removeScan(int position) {
    _scans.removeAt(position);
    loadStream();
  }

  removeAll() {
    _scans.clear();
    loadStream();
  }

  dispose() {
    _streamController?.close();
  }
}
