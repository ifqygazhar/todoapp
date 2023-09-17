import 'package:flutter/material.dart';

import 'package:todo_list/main.dart';
import 'package:todo_list/models/todo.dart';

class AddTodoScreen extends StatefulWidget {
  final void Function(Todo todo) onAddTodo;

  const AddTodoScreen({
    super.key,
    required this.onAddTodo,
  });

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _titleController = TextEditingController();
  Category _selectedCategory = Category.hobbies;

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Invalid input'),
        content: const Text('Please make sure title not empty'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text('ok'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return SizedBox(
          height: 500,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    maxLength: 30,
                    decoration: InputDecoration(
                      hintText: "Title",
                      filled: true,
                      fillColor: const Color.fromARGB(255, 240, 239, 239),
                      border: InputBorder.none,
                      focusColor: kPrimaryColor,
                      hoverColor: Colors.black,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(89, 255, 166, 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            canvasColor: kPrimaryColor,
                          ),
                          child: DropdownButton(
                            isExpanded: true,
                            icon: const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              size: 25,
                            ),
                            iconEnabledColor: Colors.white,
                            value: _selectedCategory,
                            items: Category.values
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(
                                      category.name,
                                      style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontFamily: "Poppins"),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              setState(() {
                                _selectedCategory = value;
                              });
                            },
                            underline: Container(), //remove underline
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_titleController.text.trim().isEmpty) {
                              _showDialog();
                              return;
                            }
                            final newTodo = Todo.create(
                              title: _titleController.text,
                              category: _selectedCategory,
                            );
                            widget.onAddTodo(newTodo);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text("Add todo"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
