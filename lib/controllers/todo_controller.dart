import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../utils/constants/colorpallets.dart';

class TodoController with ChangeNotifier {
  // final todoRepo = todoRepository();

  bool _loading = false;
  bool get loading => _loading;

  // late TodoModel _todo = TodoModel();
  // TodoModel get todo => _todo;

  setLoadingState(bool val) {
    _loading = val;
  }

  // todo controller for fetching all data
  // Future getAllTodos(context) async {
  //   try {
  //     setLoadingState(true);
  //     var todos = await todoRepo.getAllTodosRepo(context);
  //     _todo = todos;
  //     setLoadingState(false);
  //     notifyListeners();
  //     if (kDebugMode) {
  //       print("todos : ${_todo.todos}");
  //     }
  //   } catch (exception) {
  //     print("exception : $exception");
  //     setLoadingState(false);
  //   }
  // }

  // todo controller for fetching all data
  // Future createTodos(todoData, context) async {
  //   try {
  //     setLoadingState(true);
  //     var todos = await todoRepo.addTodo(todoData, context);
  //     setLoadingState(false);
  //     notifyListeners();
  //     Navigator.pop(context);
  //     ListnersUtils.showFlushbarMessage("${todos["todo"]}", Colors.greenAccent,
  //         TheamColors.PtexrtColor2, "Success", Icons.done, context);
  //     if (kDebugMode) {
  //       print("Create todos : ${todos}");
  //     }
  //   } catch (exception) {
  //     print("exception : $exception");
  //     setLoadingState(false);
  //   }
  // }
}
