import 'package:todo_app_with_bloc_tutorial/dao/todo_dao.dart';
import 'package:todo_app_with_bloc_tutorial/model/todo.dart';

class TodoRepository {
  final todoDao = TodoDao();

  Future getAllTodos({String? query}) =>
      todoDao.getTodos(query: query, columns: []);

  Future insertTodo(Todo todo) => todoDao.createTodo(todo);

  Future updateTodo(Todo todo) => todoDao.updateTodo(todo);

  Future deleteTodoById(int id) => todoDao.deleteTodo(id);

  //We are not going to use this in the demo
  Future deleteAllTodos() => todoDao.deleteAllTodos();
}
