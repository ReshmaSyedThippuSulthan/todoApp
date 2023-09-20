import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo2/constant/baseurl.dart';
import 'package:todo2/todo.dart';

class TodoApi {
  static Future<String> todoInsert(
      {required String todoid,
      required String todo_data,
      required String todo_datetime,
      required bool ischeck}) async {
    String url1 = "${baseurl}db_todo/Insert";
    final body= {
      "todoid": todoid,
      "todo_data": todo_data,
      "todo_datetime": todo_datetime,
      "ischeck": ischeck.toString(),
    };
                    
    var response = await http.post(Uri.parse(url1), 
    headers: {"Accept": "application/json"},  
    body: json.encode(body));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return responseBody['status'];
    } else {
      return "Insert failed";
    }
  }

  static Future<String> todoUpdate({
    required String todo_data,
    required String todo_datetime,
    required bool ischeck,
    required String todoid,
  }) async {
    print(todo_data);
    String url1 = "${baseurl}db_todo/update-tododb";
    final body = {
      "todoid": todoid,
      "todo_data": todo_data,
      "todo_datetime": todo_datetime,
      "ischeck": ischeck.toString()
    };
    var response = await http.post(Uri.parse(url1),
        headers: {'Accept': '*/*', 'Content-Type': 'application/json'},
        body: json.encode(body));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return responseBody['status'];
    } else {
      return "Update failed";
    }
  } 

  static Future<String> todoDelete({required String todoid}) async {
    String url1 = "${baseurl}db_todo/delete-tododb";
    final body ={"todoid": todoid};
    var response = await http.post(Uri.parse(url1),
     headers: {'Accept': '*/*', 'Content-Type': 'application/json'},
      body: json.encode(body));
    print(response.body);
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return responseBody['status'];
    } else {
      return 'Delete Failed';
    }
  }

  static Future<List<Todo>> getTodo() async {
    String url = "${baseurl}db_todo/get-todo";
    print(url);
    final record = await http.get(Uri.parse(url)).then((value) {
      if (value.statusCode == 200) {
        print(value.body);
        final responseBody = json.decode(value.body);
        final todoData = TodoResponse.fromJson(responseBody);
        return todoData.todo;
      } else {
        return <Todo>[];
      }
    }).catchError((onError) {
      print(onError);
      return <Todo>[];
    });
    
    return record;
  } 
}
