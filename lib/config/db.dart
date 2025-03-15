import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

Future<Database> initializeDatabase() async {
  try {
    var databasesPath = await getDatabasesPath();
    String directory = p.join(databasesPath, 'demo.db');
    Database database = await openDatabase(directory, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE task (id TEXT PRIMARY KEY, name TEXT NOT NULL, description TEXT)');
    });

    return database;
  } catch (e) {
    throw Exception(e);
  }
}
