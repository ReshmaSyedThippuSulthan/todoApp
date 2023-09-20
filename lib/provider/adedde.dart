import 'package:flutter/material.dart';
import 'package:todo2/apiconnection/todoapi.dart';
import '../todo.dart';

class TodoAdedde extends ChangeNotifier {
  List<Todo> foundToDo = []; //filter data in search box
  List<Todo> todoList = Todo.todoList(); //all data stored
  int index = 0;
  bool update = false;
  bool isFilter = false;
  List<Todo> completedTodo =[];
  List<Todo> incompletedTodo =[];
 
//checkbox
  Future getTodo() async {
    List<Todo> tempcompletedTodo =[];
    List<Todo> tempincompletedTodo =[];
    todoList = await TodoApi.getTodo();
    for (Todo todo in todoList){
    if (todo .isDone){
      tempcompletedTodo.add(todo);
    }
    else{
      tempincompletedTodo.add(todo);
    }
    completedTodo = tempcompletedTodo;
    incompletedTodo = tempincompletedTodo;
    }
    notifyListeners();
  }


  handleToDoChange(Todo todo) async {
    final index = todoList.indexWhere((item) => item.id == todo.id);
    todoList[index].isDone = !todo.isDone;
    await updateTodo(
        todoid: todoList[index].id,
        todo_data: todoList[index].todoText,
        todo_datetime: todoList[index].datetime,
        ischeck: todoList[index].isDone);
    notifyListeners();
  }

//delteicon
  deleteToDoItem(String id) async {
    print(id);
    todoList.removeWhere((item) => item.id == id);

    // final todo = Todo(
    //   id: todoList.first.id,
    //   todoText: todoList.first.todoText,
    //   datetime: todoList.first.datetime,
    // );
    // todoList.remove(todo);
    TodoApi.todoDelete(todoid: id); 
    notifyListeners();
  }

//addition
  addToDoItem(String todo, TextEditingController todoController) async {
    final todo = Todo(
      datetime: DateTime.now().toString(),
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      todoText: todoController.text.toString().trim(),
      isDone: false,
    );
    return await TodoApi.todoInsert(
        todoid: todo.id,
        todo_data: todo.todoText,
        todo_datetime: todo.datetime,
        ischeck: todo.isDone);
  }

//Edit&update
  updateToDoItems(String id, TextEditingController todoController) async {
    update = true;
    index = todoList.indexWhere((item) => item.id == id);
    if (index > -1) {
      todoController.text = todoList[index].todoText;
    } else {
      print(index);
    }
    notifyListeners();
  }

  Future<String> updateTodo(
      {required String todo_data,
      required String todo_datetime,
      required bool ischeck,
      required String todoid}) async {
    print(todo_data);
    return await TodoApi.todoUpdate(
        todo_data: todo_data,
        todo_datetime: todo_datetime,
        ischeck: ischeck,
        todoid: todoid);
  }

//filter search
  runFilter(String enterKeyword) {
    print(isFilter);
    List<Todo> results = [];
    if (enterKeyword.isEmpty) {
      isFilter = false;
      results = todoList;
    } else {
       isFilter = true;
      results = todoList 
          .where((item) =>
              item.todoText.toLowerCase().contains(enterKeyword.toLowerCase()))
          .toList();
    }
    foundToDo = results; 
    print(foundToDo); 
    notifyListeners();
  }
}
