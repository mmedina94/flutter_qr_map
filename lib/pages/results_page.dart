import 'package:chapter/models/scan_model.dart';
import 'package:chapter/utils/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:chapter/bloc/scans_bloc.dart';

class ResultsPage extends StatelessWidget {
  final ScansBloc scansBloc = ScansBloc();

  @override
  Widget build(BuildContext context) {
    scansBloc.loadStream();

    return _getListResult();
  }

  Widget _getListResult() {
    return StreamBuilder(
        stream: scansBloc.stream,
        builder:
            (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
          if (!snapshot.hasData || snapshot.data.length == 0) {
            return Center(
              child: Text("No hay informacion"),
            );
          } else {
            return _getList(snapshot.data);
          }
        });
  }

  Widget _getList(List<ScanModel> scansList) {
    return ListView.builder(
        itemCount: scansList.length,
        itemBuilder: (BuildContext context, int position) {
          return _getItem(context, scansList[position], position);
        });
  }

  Widget _getItem(BuildContext context, ScanModel scan, int position) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(color: Colors.red),
      child: _getCard(context, scan),
      onDismissed: (DismissDirection direction) {
        scansBloc.removeScan(position);
      },
    );
  }

  Widget _getCard(BuildContext context, ScanModel scan) {
    return ListTile(
      title: Text(
        scan.value,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(scan.type),
      leading: Icon(Icons.insert_emoticon, color: Colors.deepOrange),
      trailing: Icon(Icons.arrow_right_sharp),
      onTap: () {
        utils.launchURL(context, scan);
      },
    );
  }
}
