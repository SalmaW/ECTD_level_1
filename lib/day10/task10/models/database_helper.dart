import 'package:ectd/day10/task10/models/emp.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  static const int _version = 2;
  static const String _dbName = "Employee.db";

  static Future<Database> _getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async => await db.execute("CREATE TABLE Employee("
          "id INTEGER PRIMARY KEY, "
          "phone TEXT NOT NULL, "
          "name TEXT NOT NULL, "
          "email TEXT NOT NULL, "
          "pass TEXT NOT NULL, "
          "confirmPass TEXT NOT NULL)"),
      version: _version,
    );
  }

  static Future<int> addEmployee(Employee employee) async {
    final db = await _getDB();
    return await db.insert(
      "Employee",
      employee.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> updateEmployee(Employee employee) async {
    final db = await _getDB();
    return await db.update(
      "Employee",
      employee.toJson(),
      where: 'id = ?',
      whereArgs: [employee.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> deleteEmployee(Employee employee) async {
    final db = await _getDB();
    return await db.delete(
      "Employee",
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }

  static Future<List<Employee>?> getAllEmployees() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query('Employee');

    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => Employee.fromJson(maps[index]));
  }
}
