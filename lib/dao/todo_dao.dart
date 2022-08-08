import 'dart:async';
import 'package:todo_app_with_bloc_tutorial/database/database.dart';
import 'package:todo_app_with_bloc_tutorial/model/todo.dart';

class TodoDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Adds new T0do records
  Future<Future<int>?> createTodo(Todo todo) async {
    final db = await dbProvider.database;
    var result = db?.insert(todoTABLE, todo.toDatabaseJson());
    return result;
  }

  //Get All T0do items
  //Searches if query string was passed
  Future<List<Todo>?> getTodos(
      {required List<String> columns, String? query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>>? result;
    if (query != null) {
      if (query.isNotEmpty) {
        result = await db?.query(
          todoTABLE,
          columns: columns,
          where: 'description LIKE ?',
          whereArgs: ["%$query%"],
        );
      }
    } else {
      result = await db?.query(todoTABLE, columns: columns);
    }

    List<Todo>? todos = result?.isNotEmpty == true
        ? result?.map((item) => Todo.fromDatabaseJson(item)).toList()
        : [];
    return todos;
  }

  //Update T0do record
  Future<int?> updateTodo(Todo todo) async {
    final db = await dbProvider.database;

    var result = await db?.update(
      todoTABLE,
      todo.toDatabaseJson(),
      where: "id = ?",
      whereArgs: [todo.id],
    );

    return result;
  }

  //Delete T0do records
  Future<int?> deleteTodo(int id) async {
    final db = await dbProvider.database;
    var result = await db?.delete(
      todoTABLE,
      where: 'id = ?',
      whereArgs: [id],
    );

    return result;
  }

  //This will be useful when I want to delete all the categories
  Future deleteAllTodos() async {
    final db = await dbProvider.database;
    var result = await db?.delete(
      todoTABLE,
    );

    return result;
  }
}
