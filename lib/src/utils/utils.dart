import 'package:qr_scanner/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

abrirScan(BuildContext context, ScanModel scan) async{
  
  if(scan.tipo =='http') {
    
    if(await canLaunch(scan.valor)){
      await launch(scan.valor);
    } else {
      throw ('No pude ejecutar ${scan.valor}');
    }

  } else {
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }

}