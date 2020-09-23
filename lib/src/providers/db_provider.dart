import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:qr_scanner/src/models/scan_model.dart';
export 'package:qr_scanner/src/models/scan_model.dart';


class DBProvider {
  
  static Database _database;
  static final DBProvider db = DBProvider._private();

  DBProvider._private();

  Future<Database> get database async {

    if(_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {

    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE SCANS('
            'id INTEGER PRIMARY KEY,'
            'tipo TEXT,'
            'valor TEXT'
          ')'
        );
      }
      );
  }

  nuevoScan(ScanModel nuevoScan) async {

    final db = await database;

    final resultado = await db.insert('SCANS', nuevoScan.toJson());

    return resultado;
  }

  Future<ScanModel> getScanById(int id) async {
    
    final db = await database;
    
    final respuesta = await db.query(
      'SCANS', 
      where: 'id = ?', whereArgs: [id] 
      );

    return respuesta.isNotEmpty ? ScanModel.fromJson(respuesta.first) : null; 
  }

  Future<List<ScanModel>> getAllScans() async{
    
    final db = await database;

    final respuesta = await db.query('SCANS');

    List<ScanModel> listaScans = respuesta.isNotEmpty ? respuesta.map((scan) => ScanModel.fromJson(scan)).toList() : [];
  
    return listaScans;
  }

    Future<List<ScanModel>> getByTipo(String tipo) async{
    
    final db = await database;

    final respuesta = await db.rawQuery("SELECT * FROM SCANS WHERE tipo='$tipo'");

    List<ScanModel> listaScans = respuesta.isNotEmpty ? respuesta.map((scan) => ScanModel.fromJson(scan)).toList() : [];
  
    return listaScans;
  }

  Future<int> updateScan(ScanModel nuevoScan) async {
    
    final db = await database;

    final respuesta = await db.update('SCANS', nuevoScan.toJson(), where: 'id = ?', whereArgs: [nuevoScan.id]);

    return respuesta;
  }

  Future<int> deleteScan(int id) async {

    final db = await database;

    final respuesta = await db.delete('SCANS', where: 'id = ?', whereArgs: [id]);

    return respuesta;
  }

    Future<int> deleteAll() async {

    final db = await database;

    final respuesta = await db.rawDelete('DELETE FROM SCANS');

    return respuesta;
  }

}