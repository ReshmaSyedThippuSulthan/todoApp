import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo2/Homescreen.dart';
import 'package:todo2/provider/adedde.dart';
import 'package:todo2/splashscreen.dart';

void main() {
  runApp(const ToDoList());
}

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoAdedde>(create: (context) => TodoAdedde())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Splashscreen(),
      ),
    );
  }
}
