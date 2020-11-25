import 'package:chapter/models/scan_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(BuildContext context, ScanModel scanModel) async {
  if (scanModel.isWeb()) {
    if (await canLaunch(scanModel.value)) {
      await launch(scanModel.value);
    } else {
      print("error");
    }
  } else {
    //Ir al mapa
  }
}
