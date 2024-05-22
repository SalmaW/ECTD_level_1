import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class SqlHelper {
  Database? db;
  SqlHelper() {
    _init();
  }

  void _init() async {
    try {
      if (kIsWeb) {
        var factory = databaseFactoryFfiWeb;
        //test the web response
        var db = await factory.openDatabase('pos.db');
        var sqliteVersion =
            (await db.rawQuery('select sqlite_version()')).first.values.first;
        print(sqliteVersion);
      } else {
        db = await openDatabase(
          'pos.db',
          version: 1,
          onCreate: (db, version) {
            print('database created successfully');
          },
        );
      }

      print("${db.hashCode}");
    } catch (e) {
      print('Error in creating database: $e');
    }
  }
}
