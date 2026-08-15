import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:rapidpulse_my/model/user_model.dart';

// Database Helper class to manage the database operations
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE NOT NULL,
        email TEXT UNIQUE NOT NULL,
        phone TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL
      )
    ''');
  }

  // Hash password using SHA1
  String _hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha1.convert(bytes);
    return digest.toString();
  }

  // Sign up new user
  Future<Map<String, dynamic>> signUp({
    required String username,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final db = await database;
      String hashedPassword = _hashPassword(password);
      
      int id = await db.insert(
        'users',
        {
          'username': username,
          'email': email,
          'phone': phone,
          'password': hashedPassword,
        },
        conflictAlgorithm: ConflictAlgorithm.abort,
      );

      return {
        'success': true,
        'message': 'User registered successfully',
        'userId': id,
      };
    } catch (e) {
      if (e.toString().contains('UNIQUE constraint failed')) {
        return {
          'success': false,
          'message': 'User with this email, username or phone already exists.',
        };
      }
      return {
        'success': false,
        'message': 'An error occurred during registration: $e',
      };
    }
  }

  // Login user
  Future<Map<String, dynamic>> login({
    required String identifier,
    required String password,
  }) async {
    try {
      final db = await database;
      String hashedPassword = _hashPassword(password);

      List<Map<String, dynamic>> results = await db.query(
        'users',
        where: '(email = ? OR username = ?) AND password = ?',
        whereArgs: [identifier, identifier, hashedPassword],
      );

      if (results.isNotEmpty) {
        return {
          'success': true,
          'message': 'Login successful',
          'user': User.fromMap(results.first),
        };
      } else {
        return {
          'success': false,
          'message': 'Invalid email/username or password',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred during login: $e',
      };
    }
  }

  // Check if username exists
  Future<bool> usernameExists(String username) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
    return results.isNotEmpty;
  }

  // Check if email exists
  Future<bool> emailExists(String email) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return results.isNotEmpty;
  }

  // Get user by ID
  Future<Map<String, dynamic>?> getUserById(int id) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
    return results.isNotEmpty ? results.first : null;
  }

  // Delete user (optional)
  Future<void> deleteUser(int id) async {
    final db = await database;
    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}