import 'package:sqflite/sqflite.dart';
import 'package:todo_list/models/todo.dart';
import 'package:path/path.dart';

class TodoDatabase {
  static final TodoDatabase instance = TodoDatabase._init();
  static Database? _database;

  TodoDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('todos.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE todos (
      id TEXT PRIMARY KEY,
      title TEXT,
      category TEXT,
      position INTEGER 
    )
  ''');
  }

  Future<int> insert(Todo todo, int position) async {
    final db = await instance.database;
    return await db.insert('todos', todo.toMap());
  }

  Future<void> delete(String id) async {
    final db = await instance.database;
    await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Todo>> getAllTodos() async {
    final db = await instance.database;
    final result = await db.query('todos', orderBy: 'position');
    return result.map((map) => Todo.fromMap(map)).toList();
  }

  Future<void> updatePosition(Todo todo) async {
    final db = await instance.database;
    await db
        .update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }
}
