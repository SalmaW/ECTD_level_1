// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';
// import 'package:ectd/nilu_app/models/client_data.dart';
// import 'package:get_it/get_it.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class SqlHelper {
  Database? db;
  final String dbName = 'pos.db';

  // Initialize database
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
            print('Database created successfully');
          },
        );
      }
    } catch (e) {
      print('Error in creating database: $e');
    }
  }

  Future<void> getForeignKeys() async {
    await db!.rawQuery("PRAGMA foreign_keys = ON");
    var result = await db!.rawQuery("PRAGMA foreign_keys");
    print("foreign keys result: $result");
  }

  Future<bool> createTables() async {
    try {
      await getForeignKeys();
      var batch = db!.batch();
      // batch.rawQuery("""
      // PRAGMA foreign_keys = ON;
      // """);

      // batch.rawQuery("""
      // PRAGMA foreign_keys
      // """);

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

      batch.execute("""
        Create table if not exists Orders(
          id integer primary key,
          label text,
          totalPrice real,
          discount real,
          clientId integer not null,
          foreign key(clientId) references Clients(id)
          on delete restrict
          ) 
          """);

      batch.execute("""
        Create table if not exists orderProductItems(
          orderId integer,
          productId integer,
          productCount integer,
          foreign key(productId) references Products(id)
          on delete restrict
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

  // Future<void> requestPermissions() async {
  //   if (!await Permission.storage.isGranted) {
  //     await Permission.storage.request();
  //   }
  // }

  // Backup database to internal storage
  Future<bool> backupDatabase() async {
    try {
      // Request storage permission if not granted
      if (!(await Permission.storage.isGranted)) {
        var status = await Permission.storage.request();
        if (status != PermissionStatus.granted) {
          print('Permission denied for storage');
          return false;
        }
      }

      String path = await getDatabasePath();
      String backupPath = await getBackupDatabasePath();

      // Ensure the original database file exists
      if (await File(path).exists()) {
        // Copy database file to backup path
        await File(path).copy(backupPath);
        print('Database backed up successfully');
        return true;
      } else {
        print('Original database file does not exist');
        return false;
      }
    } catch (e) {
      print('Error backing up database: $e');
      return false;
    }
  }

  // Restore database from backup
  Future<bool> restoreDatabase() async {
    try {
      // Request storage permission if not granted
      if (!(await Permission.storage.isGranted)) {
        var status = await Permission.storage.request();
        if (status != PermissionStatus.granted) {
          print('Permission denied for storage');
          return false;
        }
      }

      String path = await getDatabasePath();
      String backupPath = await getBackupDatabasePath();

      // Ensure the backup database file exists
      if (await File(backupPath).exists()) {
        // Copy backup file to original database path
        await File(backupPath).copy(path);
        print('Database restored successfully');
        return true;
      } else {
        print('Backup database file does not exist');
        return false;
      }
    } catch (e) {
      print('Error restoring database: $e');
      return false;
    }
  }

  // Get path for the database file
  Future<String> getDatabasePath() async {
    String databasesPath = await getDatabasesPath();
    return join(databasesPath, 'pos.db');
  }

  // Get path for the backup database file
  Future<String> getBackupDatabasePath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    return join(appDocDir.path, 'pos_backup.db');
  }

  // Show restore confirmation dialog
  Future<bool> _showRestoreConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Restore Database'),
              content: Text('Do you want to restore the database from backup?'),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop(false); // User canceled restore
                  },
                ),
                TextButton(
                  child: Text('Restore'),
                  onPressed: () {
                    Navigator.of(context).pop(true); // User confirmed restore
                  },
                ),
              ],
            );
          },
        ) ??
        false; // Default to false if dialog is dismissed
  }

  // Restore database if needed
  Future<void> restoreDatabaseIfNeeded(BuildContext context) async {
    bool restoreConfirmed = await _showRestoreConfirmationDialog(context);
    if (restoreConfirmed) {
      bool restoreSuccess = await restoreDatabase();
      if (restoreSuccess) {
        // Database restored successfully, handle further actions if needed
        print('Database restored successfully');
      } else {
        // Handle restore failure
        print('Failed to restore database');
      }
    } else {
      // User canceled restore
      print('Restore canceled by user');
    }
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
