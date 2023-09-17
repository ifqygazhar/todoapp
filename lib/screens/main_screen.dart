import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:todo_list/main.dart';
import 'package:todo_list/models/todo_database.dart';

import 'package:todo_list/screens/add_todo.dart';
import 'package:todo_list/screens/help.dart';
import 'package:todo_list/widgets/todolist.dart';
import 'package:todo_list/widgets/banner.dart';
import 'package:todo_list/models/todo.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Todo> _todos = [];
  int _removedTodoPosition = 0;

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  void _loadTodos() async {
    final todos = await TodoDatabase.instance.getAllTodos();
    setState(() {
      _todos = todos;
    });
  }

  void _addTodo(Todo todo) async {
    final id = await TodoDatabase.instance.insert(todo, _removedTodoPosition);
    final newTodo = Todo(
      title: todo.title,
      category: todo.category,
      id: id.toString(),
      position: _removedTodoPosition,
    );
    setState(() {
      _todos.insert(_removedTodoPosition, newTodo);
      _resetTodoPositions();
    });
  }

  void _resetTodoPositions() {
    for (int i = 0; i < _todos.length; i++) {
      _todos[i].position = i;
    }
  }

  void _removeTodo(Todo todo) async {
    _removedTodoPosition = _todos.indexOf(todo);
    await TodoDatabase.instance.delete(todo.id);
    if (_todos.contains(todo)) {
      setState(() {
        _todos.remove(todo);
      });
    }
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Todo deleted"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(
              () {
                _addTodo(todo);
              },
            );
          },
        ),
      ),
    );
  }

  void _openAddTodo() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (ctx) => AddTodoScreen(
        onAddTodo: _addTodo,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/images/empty.svg",
              width: 200,
              height: 200,
            ),
            const Text(
              "Try add some todo",
              style: TextStyle(fontFamily: "Poppins"),
            ),
          ],
        ),
      ),
    );
    if (_todos.isNotEmpty) {
      mainContent = TodoListWidget(
        todos: _todos,
        onRemoveTodo: _removeTodo,
      );
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTodo,
        backgroundColor: kPrimaryColor,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 28,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 0, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "TODOAPP",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Poppins",
                            fontSize: 28,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => const HelpScreen(),
                        ),
                      ),
                      child: const CircleAvatar(
                        backgroundColor: Color.fromARGB(89, 255, 166, 2),
                        child: Icon(Icons.help),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const BannerWidget(),
            Expanded(child: mainContent),
          ],
        ),
      ),
    );
  }
}
