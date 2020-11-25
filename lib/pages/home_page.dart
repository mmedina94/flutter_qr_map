import 'package:chapter/bloc/scans_bloc.dart';
import 'package:chapter/models/scan_model.dart';
import 'package:chapter/pages/contact_page.dart';
import 'package:chapter/pages/results_page.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scanBloc = new ScansBloc();

  final _menuOptions = [
    {'title': 'Resultados', 'icon': Icons.scanner},
    {'title': 'Contactos', 'icon': Icons.contact_mail},
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppbar(),
      bottomNavigationBar: _getBottomNavigationBar(),
      floatingActionButton: _getFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _getCurrentPage(),
    );
  }

  Widget _getAppbar() {
    return AppBar(
      title: Text('Home Page'),
      actions: [
        IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {},
        )
      ],
    );
  }

  Widget _getFloatingActionButton() {
    return FloatingActionButton(
      onPressed: _scanQr,
      child: Icon(Icons.camera),
    );
  }

  Widget _getBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      items: _getBottomNavigationItems(),
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

  List<BottomNavigationBarItem> _getBottomNavigationItems() {
    return _menuOptions
        .map((element) => BottomNavigationBarItem(
              icon: Icon(element['icon']),
              label: element['title'],
            ))
        .toList();
  }

  Widget _getCurrentPage() {
    if (_currentIndex == 0) {
      return ResultsPage();
    } else {
      return ContactPage();
    }
  }

  void _scanQr() async {
    try {
      var scanResult = await BarcodeScanner.scan();
      var scanValue = scanResult.rawContent;

      if (scanResult.type != ResultType.Cancelled &&
          scanValue != null &&
          scanValue.isNotEmpty) {
        _scanBloc.addScan(ScanModel(value: scanValue));
      }
    } catch (error) {
      print("Ocurrio un error");
    }
  }
}
