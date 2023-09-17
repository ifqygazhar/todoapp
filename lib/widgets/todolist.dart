import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/models/todo_database.dart';
import 'package:todo_list/widgets/todolist_item.dart';

class TodoListWidget extends StatefulWidget {
  final List<Todo> todos;
  final void Function(Todo todo) onRemoveTodo;

  const TodoListWidget({
    super.key,
    required this.todos,
    required this.onRemoveTodo,
  });

  @override
  State<TodoListWidget> createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  void updateMyPositionTodo(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex--;
      }
      final item = widget.todos.removeAt(oldIndex);
      widget.todos.insert(newIndex, item);
      for (int i = 0; i < widget.todos.length; i++) {
        widget.todos[i].position = i;
      }
      _updateTodoPositions();
    });
  }

  void _updateTodoPositions() async {
    for (int i = 0; i < widget.todos.length; i++) {
      await TodoDatabase.instance.updatePosition(widget.todos[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget proxyDecorator(
        Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          return Material(
            elevation: 0,
            color: Colors.transparent,
            child: child,
          );
        },
        child: child,
      );
    }

    return ReorderableListView.builder(
      proxyDecorator: proxyDecorator,
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(widget.todos[index]),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            widget.onRemoveTodo(widget.todos[index]);
          },
          background: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
            child: Container(
              width: 380,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color.fromARGB(255, 252, 139, 131),
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 32,
                    ),
                  ],
                ),
              ),
            ),
          ),
          child: TodoListItemWidget(
            todo: widget.todos[index],
            todoIndex: index,
          ),
        );
      },
      itemCount: widget.todos.length,
      onReorder: (oldIndex, newIndex) => updateMyPositionTodo(
        oldIndex,
        newIndex,
      ),
    );
  }
}
