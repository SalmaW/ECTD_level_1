import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class SqlHelper {
  Database? db;

  Future<void> init() async {
    try {
      if (kIsWeb) {
        var factory = databaseFactoryFfiWeb;
        db = await factory.openDatabase('pos.db');
      } else {
        db = await openDatabase(
          'pos.db',
          version: 1,
          onCreate: (db, version) {
            print('database created successfully');
          },
        );
      }
    } catch (e) {
      print('Error in creating database: $e');
    }
  }

  Future<bool> createTables() async {
    try {
      var batch = db!.batch();
      batch.execute("""
        Create table if not exists Categories(
          id integer primary key,
          name text not null,
          description text not null
          ) 
          """);

      batch.execute("""
        Create table if not exists Products(
          id integer primary key,
          name text not null,
          description text not null,
          price double not null,
          stock integer not null,
          isAvailable boolean not null,
          image blob,
          categoryId integer not null
          ) 
          """);

      batch.execute("""
        Create table if not exists Clients(
          id integer primary key,
          name text not null,
          email text,
          phone text,
          address text
          ) 
          """);

      var result = await batch.commit();
      print('results $result');
      return true;
    } catch (e) {
      print('Error in creating table: $e');
      return false;
    }
  }

  // Future<bool> createTables() async {
  //   try {
  //     await batch.execute("""
  //       Create table if not exists Categories(
  //         id integer primary key,
  //         name text not null,
  //         description text not null
  //         )
  //         """);
  //
  //     await batch.execute("""
  //       Create table if not exists Products(
  //         id integer primary key,
  //         name text not null,
  //         description text not null,
  //         price double not null,
  //         stock integer not null,
  //         isAvailable boolean not null,
  //         image blob,
  //         categoryId integer not null
  //         )
  //         """);
  //
  //     await batch.execute("""
  //       Create table if not exists Clients(
  //         id integer primary key,
  //         name text not null,
  //         email text,
  //         phone text,
  //         address text
  //         )
  //         """);
  //
  //   } catch (e) {
  //     print('Error in creating table: $e');
  //   }
  // }
}
