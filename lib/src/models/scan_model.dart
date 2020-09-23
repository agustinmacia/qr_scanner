import 'package:latlong/latlong.dart';

class ScanModel {
    
    ScanModel({
        this.id,
        this.tipo,
        this.valor,
    }){
      if(valor.contains('http')) {
        this.tipo = 'http';
      } else {
        this.tipo = 'geo';
      }
    }

    int id;
    String tipo;
    String valor;

    factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id    : json["id"],
        tipo  : json["tipo"],
        valor : json["valor"],
    );

    Map<String, dynamic> toJson() => {
        "id"    : id,
        "tipo"  : tipo,
        "valor" : valor,
    };

    LatLng getLatitudLongitud() {
      final latitudLongitud = valor.substring(4).split(',');
      final latitud = double.parse(latitudLongitud[0]);
      final longitud = double.parse(latitudLongitud[1]);
      
      return LatLng(latitud, longitud);
    }
}
