import 'package:flutter/material.dart';
import 'package:qr_scanner/src/pages/despliegue_mapa.dart';
import 'package:qr_scanner/src/pages/direcciones_page.dart';
import 'package:qr_scanner/src/pages/mapas_page.dart';
import 'package:qr_scanner/src/pages/home_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lector QR',
      initialRoute: 'home',
      routes: {
        'home'        : (BuildContext context) => HomePage(),
        'mapas'       : (BuildContext context) => MapasPage(),
        'mapa'        : (BuildContext context) => MapaPage(),
        'direcciones' : (BuildContext context) => DireccionesPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.green,

      ),
    );
  }
}