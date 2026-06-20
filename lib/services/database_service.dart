import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/habit.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('habit_app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        uid TEXT PRIMARY KEY,
        email TEXT UNIQUE,
        displayName TEXT,
        password TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE habits (
        id TEXT PRIMARY KEY,
        uid TEXT,
        name TEXT,
        category TEXT,
        colorValue INTEGER,
        icon TEXT,
        createdAt TEXT,
        history TEXT
      )
    ''');
  }

  // --- Auth logic ---
  Future<int> registerUser(String email, String password, String displayName) async {
    final db = await instance.database;
    final uid = DateTime.now().millisecondsSinceEpoch.toString();

    try {
      return await db.insert('users', {
        'uid': uid,
        'email': email,
        'password': password,
        'displayName': displayName,
      });
    } catch (_) {
      // Email already exists or insert error
      return -1;
    }
  }

  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    final db = await instance.database;
    final res = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (res.isNotEmpty) {
      return res.first;
    }
    return null;
  }

  // --- Habit logic ---
  Future<List<Habit>> getHabits(String uid) async {
    final db = await instance.database;
    final res = await db.query(
      'habits',
      where: 'uid = ?',
      whereArgs: [uid],
      orderBy: 'createdAt DESC',
    );

    return res.map((map) {
      final historyMap = json.decode(map['history'] as String? ?? '{}') as Map<String, dynamic>;
      final Map<String, bool> parsedHistory = historyMap.map((key, value) => MapEntry(key, value as bool));

      return Habit(
        id: map['id'] as String,
        name: map['name'] as String,
        category: map['category'] as String? ?? 'General',
        colorValue: map['colorValue'] as int? ?? 0xFF6C63FF,
        icon: map['icon'] as String? ?? '💧',
        createdAt: DateTime.tryParse(map['createdAt'] as String? ?? '') ?? DateTime.now(),
        history: parsedHistory,
      );
    }).toList();
  }

  Future<int> insertHabit(String uid, Habit habit) async {
    final db = await instance.database;
    return await db.insert('habits', {
      'id': habit.id,
      'uid': uid,
      'name': habit.name,
      'category': habit.category,
      'colorValue': habit.colorValue,
      'icon': habit.icon,
      'createdAt': habit.createdAt.toIso8601String(),
      'history': json.encode(habit.history),
    });
  }

  Future<int> updateHabit(String uid, Habit habit) async {
    final db = await instance.database;
    return await db.update(
      'habits',
      {
        'name': habit.name,
        'category': habit.category,
        'colorValue': habit.colorValue,
        'icon': habit.icon,
        'createdAt': habit.createdAt.toIso8601String(),
        'history': json.encode(habit.history),
      },
      where: 'id = ? AND uid = ?',
      whereArgs: [habit.id, uid],
    );
  }

  Future<int> deleteHabit(String uid, String id) async {
    final db = await instance.database;
    return await db.delete(
      'habits',
      where: 'id = ? AND uid = ?',
      whereArgs: [id, uid],
    );
  }
}
