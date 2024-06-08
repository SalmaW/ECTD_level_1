// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';
// import 'package:ectd/nilu_app/models/client_data.dart';
// import 'package:get_it/get_it.dart';
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
      await db!.execute("""
      PRAGMA foreign_keys = ON;
      """);

      var batch = db!.batch();
      // batch.rawQuery("""
      // PRAGMA foreign_keys = ON;
      // """);

      batch.rawQuery("""
      PRAGMA foreign_keys 
      """);

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
          image text,
          categoryId integer not null,
          foreign key(categoryId) references Categories(id)
          on delete restrict
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

  Future<int> getDependentProductCount(int categoryId) async {
    var result = await db!.rawQuery(
        'SELECT COUNT(*) FROM Products WHERE categoryId = ?', [categoryId]);
    return Sqflite.firstIntValue(result) ?? 0;
  }

  // static Future<int> deleteClient(ClientData client) async {
  //   var sqlHelper = GetIt.I.get<SqlHelper>();
  //   return await sqlHelper.db!.delete(
  //     "Clients",
  //     where: 'id = ?',
  //     whereArgs: [client.id],
  //   );
  // }
  //
  // static Future<List<ClientData>?> getAllClients() async {
  //   var sqlHelper = GetIt.I.get<SqlHelper>();
  //   final List<Map<String, dynamic>> maps =
  //       await sqlHelper.db!.query('Clients');
  //
  //   if (maps.isNotEmpty) {
  //     //return [];
  //     return List.generate(
  //         maps.length, (index) => ClientData.fromJson(maps[index]));
  //   }
  //   return [];
  // }
  //
  // static Future<int> updateClient(ClientData client) async {
  //   var sqlHelper = GetIt.I.get<SqlHelper>();
  //   return await sqlHelper.db!.update(
  //     "Clients",
  //     client.toJson(),
  //     where: 'id = ?',
  //     whereArgs: [client.id],
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }
  //
  // static Future<int> addClient(ClientData client) async {
  //   var sqlHelper = GetIt.I.get<SqlHelper>();
  //   return await sqlHelper.db!.insert(
  //     "Clients",
  //     client.toJson(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }

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
