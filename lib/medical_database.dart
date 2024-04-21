import 'package:medical_trigger/medical_record.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MedicalDatabase {
  static final MedicalDatabase instance = MedicalDatabase._init();
  static Database? _database;

  MedicalDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('medical_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS StaticRecords(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        address TEXT,
        tableName TEXT,
        phoneNumber INTEGER,
        age INTEGER
      )
    ''');
  }

  Future<void> addOrUpdateRecord(Map<String, dynamic> record) async {
    final db = await instance.database;
    final name = record['name'] as String;
    final phoneNumber = record['phoneNumber'] as int;
    final address = record['address'] as String;

    // Check if the person exists in static records
    final personExists = await _personExists(name, phoneNumber);
    if (personExists) {
      final tableName = await _getTableName(name, phoneNumber);
      await db.insert(tableName!, record);
    } else {
      final id = await db.insert('StaticRecords', {
        'name': name,
        'phoneNumber': phoneNumber,
        'age': record['age'],
        'address': address, // Add address field here
      });
      final tableName = '$name$id'; // Create table name using name and id
      await _createPersonTable(tableName);
      await db.update(
        'StaticRecords',
        {'id': id, 'tableName': tableName}, // Add 'tableName' here
        where: 'id = ?',
        whereArgs: [id],
      );
    }
  }

  Future<bool> _personExists(String name, int id) async {
    final db = await instance.database;
    final result = await db.query(
      'StaticRecords',
      where: 'name = ? AND id = ?',
      whereArgs: [name, id],
    );
    return result.isNotEmpty;
  }

  Future<String?> _getTableName(String name, int id) async {
    final db = await instance.database;
    final result = await db.query(
      'StaticRecords',
      columns: ['tableName'],
      where: 'name = ? AND id = ?',
      whereArgs: [name, id],
    );
    if (result.isNotEmpty) {
      return result.first['tableName'] as String;
    } else {
      return null;
    }
  }

  Future<void> _createPersonTable(String tableName) async {
    final db = await instance.database;
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        bloodPressure REAL,
        temperature REAL,
        height REAL,
        weight REAL,
        glucoseLevel REAL
      )
    ''');
  }

  Future<List<MedicalRecord>> getAllRecords() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('StaticRecords');
    return List.generate(maps.length, (i) {
      return MedicalRecord(
        id: maps[i]['id'] != null ? int.parse(maps[i]['id'].toString()):null,
        name: maps[i]['name'] ?? null,
        phoneNumber: maps[i]['phoneNumber'] != null ? int.parse(maps[i]['phoneNumber'].toString()):null,
        age: maps[i]['age'] != null ? int.parse(maps[i]['age'].toString()):null,
        bloodPressure: maps[i]['bloodPressure'] != null ? double.parse(maps[i]['bloodPressure'].toString()) : null,
temperature: maps[i]['temperature'] != null ? double.parse(maps[i]['temperature'].toString()) : null,
height: maps[i]['height'] != null ? double.parse(maps[i]['height'].toString()) : null,
weight: maps[i]['weight'] != null ? double.parse(maps[i]['weight'].toString()) : null,
glucoseLevel: maps[i]['glucoseLevel'] != null ? double.parse(maps[i]['glucoseLevel'].toString()) : null,
aadharNumber: maps[i]['adhaarNumber'],
address: maps[i]['address'],
gender: maps[i]['gender'],
spouseOrFatherName: maps[i]['spouseOrFatherName'],
      );
    }).where((record) => record.id != null).toList();
  }

  Future<void> deleteRecord(int id) async {
    final db = await instance.database;
    await db.delete(
      'StaticRecords',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
