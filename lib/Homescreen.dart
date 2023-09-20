import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo2/provider/adedde.dart';
import 'package:todo2/todoItems.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController filterController = TextEditingController();
  int index = 0;
  // bool update = false;
  // List<Todo> _foundToDo= [];
  // final todoList = Todo.todoList();
  // var  time = DateTime.now();
  // DateFormat formatter = DateFormat(' dd MMM y,  hh:mm:ss');
  final todoController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Provider.of<TodoAdedde>(context, listen: false).getTodo();
    // Future.delayed(Duration.zero, () async {
    //   final todoProvider = Provider.of<TodoAdedde>(context, listen: false);
    //   final String todo = await Shared.getString('todosData');
    //   setState(() {
    //     todoProvider.todoList = Todo.decode(todo);
    //   });
    // });
  }

  @override
  void dispose() {
    todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoAdedde>(
      builder: (BuildContext context, todoValue, Widget? child) {
        return DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 216, 178, 178),
            appBar: _buildAppBar(),
            body: TabBarView(
              children: [
                Stack(
                  children: [
                    Container(
                      color: const Color.fromARGB(255, 216, 178, 178),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          searchBox(),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20, bottom: 5),
                            child: const Text(
                              "All ToDo's",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Expanded(
                              child: ListView.builder(
                                  itemCount: todoValue.isFilter
                                      ? todoValue.foundToDo.length
                                      : todoValue.todoList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return TodoItems(
                                      todo: todoValue.isFilter
                                          ? todoValue.foundToDo[index]
                                          : todoValue.todoList[index],
                                      onToDoChanged: todoValue.handleToDoChange,
                                      onDEleteItem: todoValue.deleteToDoItem,
                                      onUpdateItem: todoValue.updateToDoItems,
                                      todocontroller: todoController,
                                    );
                                  })),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(
                                bottom: 20,
                                right: 20,
                                left: 20,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 10.0,
                                        spreadRadius: 0)
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: TextField(
                                controller: todoController,
                                decoration: const InputDecoration(
                                    hintText: 'Add a new todo item',
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                          Container(
                            margin:
                                const EdgeInsets.only(bottom: 20, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (todoController.text.isNotEmpty) {
                                  if (todoValue.update) {
                                    todoValue.todoList[todoValue.index]
                                        .todoText = todoController.text;
                                    todoValue.todoList[todoValue.index]
                                            .datetime =
                                        DateTime.now().toIso8601String();
                                    //update
                                    print(todoValue
                                        .todoList[todoValue.index].todoText);
                                    await todoValue.updateTodo(
                                        todoid: todoValue
                                            .todoList[todoValue.index].id,
                                        todo_data: todoValue
                                            .todoList[todoValue.index].todoText,
                                        todo_datetime: todoValue
                                            .todoList[todoValue.index].datetime,
                                        ischeck: todoValue
                                            .todoList[todoValue.index].isDone);
                                    //delete
                                    todoValue.deleteToDoItem;
                                    setState(() {
                                      todoValue.update = false;
                                    });
                                  } else {
                                    final status = await todoValue.addToDoItem(
                                        todoController.text, todoController);
                                    var mgs = SnackBar(content: Text(status));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(mgs);
                                    //  _addToDoItem(_todoController.text);
                                  }
                                  todoValue.getTodo();
                                } else {
                                  const mgs = SnackBar(
                                      content: Text("Please add a TodoList"));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(mgs);
                                }
                                todoController.clear();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 216, 178, 178),
                                  minimumSize: const Size(60, 60),
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              child: todoValue.update
                                  ? const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    )
                                  : const Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  color: const Color.fromARGB(255, 216, 178, 178),
                  child: Column(
                    children: [
                      const Text(
                        "Completed",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //completed
                      todoValue.completedTodo.isEmpty
                          ? const Text("No Data")
                          : Expanded(
                              child: ListView.builder(
                                itemCount: todoValue.completedTodo.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return TodoItems(
                                    todo: todoValue.completedTodo[index],
                                    onToDoChanged: todoValue.handleToDoChange,
                                    onDEleteItem: todoValue.deleteToDoItem,
                                    onUpdateItem: todoValue.updateToDoItems,
                                    todocontroller: todoController,
                                  );
                                }, //
                              ),
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Incompleted",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //Incompleted
                      todoValue.incompletedTodo.isEmpty
                          ? const Text("No Data")
                          : Expanded(
                              child: ListView.builder(
                                itemCount: todoValue.incompletedTodo.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return TodoItems(
                                    todo: todoValue.incompletedTodo[index],
                                    onToDoChanged: todoValue.handleToDoChange,
                                    onDEleteItem: todoValue.deleteToDoItem,
                                    onUpdateItem: todoValue.updateToDoItems,
                                    todocontroller: todoController,
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
// void _handleToDoChange(Todo todo){
//   setState(() {
//    todo.isDone =! todo.isDone;
// });
// }

// void _deleteToDoItem(String id) {
//   setState(() {
//     todoList.removeWhere((item) => item.id == id);
//   });
// }
// void _UpdateToDoItems(String id){
//   setState(() {
//     update =true;
//      index =  todoList.indexWhere((item) => item.id ==id);
//      _todoController.text= todoList[index].todoText ;
//     // todoList[index].todoText=todoText;
//   });
//    _todoController.clear();
// }

// void _addToDoItem(String todo){
//   setState(() {
//     todoList.add(Todo(datetime: DateTime.now(),id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: _todoController.text.toString().trim(),),);
// });
//   _todoController.clear();

// }

// void _runFilter(String enterKeyword){
//   List<Todo> results =[];
//   if(enterKeyword.isEmpty){
//     results = todoList;
//   }
//   else{
//     results=todoList
//     .where((item) => item.todoText!
//     .toLowerCase()
//     .contains(enterKeyword.toLowerCase()))
//     .toList();
//   }
//   setState(() {
//     _foundToDo = results;
//   });
// }

//  void UpdateToDoItems(String id,){
//   final todoprovider=Provider.of<Todo_Adedde >(context,listen: false);
//   todoprovider.update =true;
//     // todoprovider. index =todoprovider.  todoList.indexWhere((item) => item.id ==id);
//     //  todoController.text=todoprovider. todoList[todoprovider.index].todoText;
//     //  print(todoList[index].todoText);
//     //  print(todoController.text);
//     //  notifyListeners();
//     // todoList[index].todoText=todoText;
//     setState(() {
//       todoprovider. index =todoprovider.  todoList.indexWhere((item) => item.id ==id);
//      todoController.text=todoprovider. todoList[todoprovider.index].todoText;
//     });
//   //  todoController.clear();
// }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        // controller: filterController,
        onChanged: (keyword) =>
            Provider.of<TodoAdedde>(context, listen: false).runFilter(keyword),
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
            border: InputBorder.none,
            hintText: "search",
            hintStyle: TextStyle(color: Colors.grey)),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      // automaticallyImplyLeading: false,
      backgroundColor: const Color.fromARGB(255, 216, 178, 178),
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Icon(Icons.menu, color: Colors.black, size: 30),
          SizedBox(
            height: 40,
            width: 40,
            // child: ClipRRect(
            //   borderRadius: BorderRadius.circular(20),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "http://www.shadowsphotography.co/wp-content/uploads/2017/12/photography-01-800x400.jpg"),
              maxRadius: 50,
            ),
            // ),
          )
        ],
      ),
      bottom: const TabBar(tabs: [
        Tab(
          icon: Icon(Icons.home),
        ),
        Tab(
          icon: Icon(Icons.check_circle),
        ),
      ]),
    );
  }
}
