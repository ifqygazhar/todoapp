import 'package:flutter/material.dart';

import 'package:todo_list/main.dart';
import 'package:todo_list/models/todo.dart';

class TodoListItemWidget extends StatelessWidget {
  final Todo todo;
  final int todoIndex;
  const TodoListItemWidget({
    super.key,
    required this.todo,
    required this.todoIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        width: 380,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: todoIndex == 0 ? kPrimaryColor : Colors.white,
          boxShadow: const [
            BoxShadow(
                blurRadius: 4,
                color: Color.fromARGB(26, 54, 54, 54),
                spreadRadius: 4)
          ],
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          child: Row(
            children: [
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: todoIndex == 0
                      ? const Color.fromRGBO(255, 255, 255, 0.176)
                      : const Color.fromRGBO(0, 0, 0, 0.07),
                ),
                child: Image.asset(
                  categoryIcon[todo.category]!,
                  width: 25,
                  height: 25,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                todo.title,
                style: TextStyle(
                  color: todoIndex == 0 ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
