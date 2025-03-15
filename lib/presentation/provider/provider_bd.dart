import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taskify/config/db.dart';
import 'package:taskify/domains/entity_task.dart';

class ProviderBd with ChangeNotifier {
  Database? database;

  Future<void> openDB() async {
    try {
      database = await initializeDatabase();

      if (database == null) {
        throw Exception("Error al abrir la base de datos");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Map<String, dynamic>>> getTask() async {
    try {
      if (database == null) {
        throw Exception("La base de datos no está abierta");
      }

      return await database!.rawQuery("SELECT * FROM task");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> addTask(EntityTask task) async {
    try {
      if (database == null) {
        throw Exception("La base de datos no está abierta");
      }

      await database!.insert("task", task.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateTask(EntityTask task) async {
    try {
      if (database == null) {
        throw Exception("La base de datos no está abierta");
      }

      await database!.update("task", task.toMapUpdate(),
          where: "id = ?", whereArgs: [task.id]);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> removeTask(EntityTask task) async {
    try {
      if (database == null) {
        throw Exception("La base de datos no está abierta");
      }

      await database!.delete("task", where: "id = ?", whereArgs: [task.id]);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> closeDB() async {
    try {
      if (database == null) {
        return;
      }
      await database!.close();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
