import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../configs/constant.dart';
import '../controllers/controllers.dart';

class EditButton extends StatelessWidget {
  EditButton({required this.todoId, super.key});

  final String todoId;

  final TodoController _todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        splashColor: kPrimary,
        onTap: () => updateTodo(),
        child: Container(
          padding: const EdgeInsets.only(top: 20.0),
          color: Colors.black87,
          width: double.infinity,
          height: 100,
          child: const Text(
            'Save & Update',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ),
    );
  }

  void updateTodo() async {
    if (_todoController.titleController.text.isEmpty) {
      _todoController.isTitleEmpty.value = true;
    }

    if (_todoController.titleController.text.isNotEmpty) {
      await _todoController.updateTodo(todoId).then((value) {
        Get.back();
      });
    }
    ;
  }
}
