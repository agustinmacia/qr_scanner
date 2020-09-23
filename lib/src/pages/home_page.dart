import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_scanner/src/bloc/scans_bloc.dart';
import 'package:qr_scanner/src/models/scan_model.dart';
import 'package:qr_scanner/src/pages/direcciones_page.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:qr_scanner/src/utils/utils.dart' as utils;
import 'mapas_page.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  final scansBloc = new ScansBloc();
  int _currentIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lector de QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: scansBloc.borrarScans,
          ),
        ],
      ),
      body: Center(
        child: _cargarPagina(_currentIndex),
      ),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: () => _lecturaDeQR(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _crearBottomNavigationBar() {


    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Mapas')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Direcciones')
        ),
      ],
    );
  }

    _lecturaDeQR(BuildContext context) async {
 
      dynamic futureString ='https://fernando-herrera.com';
  
      if (futureString != null) {
        final scan = ScanModel(valor: futureString);
        scansBloc.agregarScan(scan);

        final scan2 = ScanModel(valor: 'geo:-34.6035097,-58.4646116');
        scansBloc.agregarScan(scan2);
        if(Platform.isIOS) {
          Future.delayed(Duration(milliseconds: 750), () {
            utils.abrirScan(context, scan);
          });
        } else {
          utils.abrirScan(context, scan);
        }

        
      }
  }

  Widget _cargarPagina(int paginaActual) {

    switch(paginaActual) {
      case 0 : 
        return MapasPage();
      case 1 : 
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }

}