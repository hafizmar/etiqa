import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../configs/constant.dart';
import '../configs/theme.dart';
import '../controllers/controllers.dart';

class TitleTextBox extends StatelessWidget {
  TitleTextBox({super.key});

  final TodoController _todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'To-Do Title',
          style: TextStyle(
              color: isLightTheme(context) ? Colors.grey[600] : Colors.white,
              fontWeight: FontWeight.bold),
        ),
        Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: _todoController.isTitleEmpty.value
                          ? Colors.red
                          : Colors.transparent,
                      width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: isLightTheme(context) ? kBubbleLight : kBubbleDark,
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextField(
                  minLines: 5,
                  maxLines: 10,
                  onChanged: (value) {
                    _todoController.isTitleEmpty.value = false;

                    _todoController.titleController.text = value;
                  },
                  controller: _todoController.titleController,
                  decoration: InputDecoration(
                    hintText: 'Please key in your To-Do title here',
                    hintStyle: TextStyle(
                        color: isLightTheme(context)
                            ? Colors.grey[500]
                            : Colors.white,
                        fontSize: 18.0),
                    border: InputBorder.none,
                    errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  style: TextStyle(
                      color:
                          isLightTheme(context) ? Colors.black : Colors.white),
                ),
              ),
              _todoController.isTitleEmpty.value
                  ? const Text(
                      'To-Do title cannot be empty.',
                      style: TextStyle(color: Colors.red),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}
