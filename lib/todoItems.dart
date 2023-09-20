import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo2/provider/adedde.dart';
import 'package:todo2/todo.dart';

class TodoItems extends StatelessWidget {
  final Todo todo;
  final onToDoChanged;
  final onDEleteItem;
  final onUpdateItem;
  final TextEditingController todocontroller;
  final DateFormat formatter = DateFormat(' dd MMM y,  hh:mm:ss');
  TodoItems({
    Key? key,
    required this.todo,
    this.onToDoChanged,
    this.onDEleteItem,
    this.onUpdateItem,
    required this.todocontroller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () async {
          print("Clicked on Todo Items");
          onToDoChanged(todo);
          Provider.of<TodoAdedde>(context,listen: false).getTodo();
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.grey[200],
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.black,
        ),
        title: Text(
          todo.todoText,
          style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              decoration: todo.isDone ? TextDecoration.lineThrough : null),
        ),
        subtitle: Text(DateFormat('dd MMM y, hh:mm:ss')
            .format(DateTime.parse(todo.datetime))),
        trailing: SizedBox(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.symmetric(vertical: 12),
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: IconButton(
                    onPressed: () {
                      print("Clicked on delete icon");
                      print(todo.id);
                      onDEleteItem(todo.id);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 18,
                    )),
              ),
              Container(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.symmetric(vertical: 12),
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: IconButton(
                  onPressed: () {
                    print("Clicked on update icon");
                    onUpdateItem(
                      todo.id,
                      todocontroller,
                    );
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.green,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
