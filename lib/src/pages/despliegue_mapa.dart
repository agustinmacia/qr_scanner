import 'package:flutter/material.dart';
import 'package:qr_scanner/src/models/scan_model.dart';
import 'package:flutter_map/flutter_map.dart';

class MapaPage extends StatefulWidget {
  
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final map = new MapController();

  String tipoMapa = 'mapbox/streets-v11';

  @override
  Widget build(BuildContext context) {
    
    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){
              map.move(scan.getLatitudLongitud(), 15);
            }, 
            )
        ],
      ),
      body: _armadoMapa(scan),
      floatingActionButton: _crearBotonFlotante(context),
    );
  }

  Widget _armadoMapa(ScanModel scan) {


    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: scan.getLatitudLongitud(),
        zoom: 10,
      ),
      layers: [
        _crearMapa(),
        _crearMarcadores(scan),
      ],
    );
  }

  _crearMapa() {

    return TileLayerOptions(
        urlTemplate: 'https://api.mapbox.com/styles/v1/'
                     '{id}/tiles/{z}/{x}/{y}@2x?access_token={accessToken}',
        additionalOptions: {
        'accessToken':'pk.eyJ1IjoiYW1hY2lhZGVscmlvIiwiYSI6ImNrYm9nbGdkYTIyNmwyd215eTJhdGIwZncifQ.gfH21PNCkT9wB9d3GIz91g',
        'id': '$tipoMapa'
        /* 
            mapbox/streets-v11,
            mapbox/light-v10,
            mapbox/dark-v10,
            mapbox/outdoors-v11,
            mapbox/satellite-v9
        */
        }
    );
  }

  _crearMarcadores(ScanModel scan) {

    return MarkerLayerOptions(
      markers: <Marker> [
        Marker(
          width: 100,
          height: 100,
          point: scan.getLatitudLongitud(),
          builder: (context) => Container(
            child: Icon(
              Icons.location_on,
              color: Theme.of(context).primaryColor,
              size: 70.0),
          )
        )
      ]
    );
  }

  Widget _crearBotonFlotante(BuildContext context) {
    return FloatingActionButton(

      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: (){
        if(tipoMapa == 'mapbox/streets-v11') {
          tipoMapa = 'mapbox/dark-v10';
        }
        else if(tipoMapa== 'mapbox/dark-v10'){
          tipoMapa = 'mapbox/light-v10';
        }
        else if(tipoMapa == 'mapbox/light-v10'){
          tipoMapa = 'mapbox/outdoors-v11';
        }
        else if(tipoMapa == 'mapbox/outdoors-v11') {
          tipoMapa = 'mapbox/satellite-v9';
        }
        else {
          tipoMapa = 'mapbox/streets-v11';
        }

        setState(() {
          
        });
      },
    );
  }
}