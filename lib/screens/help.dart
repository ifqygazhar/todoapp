import 'package:flutter/material.dart';
import 'package:todo_list/main.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "How to use TODOAPP ?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "1. Delete todo",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "To delete a todo, you can swipe left.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: "Poppins",
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "2. Change priority todo",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "To change priority todo you can drag and drop the todo.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: "Poppins",
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "3. Add todo",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "To add todo you can click icon in bottom corner.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: "Poppins",
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Back",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
