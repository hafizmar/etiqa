import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../configs/constant.dart';
import '../../controllers/controllers.dart';
import '../../widgets/widgets.dart';

class TodoEdit extends StatelessWidget {
  TodoEdit({Key? key}) : super(key: key);

  // calling todoController
  final TodoController _todoController = Get.put(TodoController());

  // assign arguments to variable
  final String todoId = Get.arguments[0];
  final String title = Get.arguments[1];
  final String startDate = Get.arguments[2];
  final String endDate = Get.arguments[3];

  @override
  Widget build(BuildContext context) {
    // assign variable to rx variable
    _todoController.titleController.text = title;
    _todoController.startDate.value = startDate;
    _todoController.endDate.value = endDate;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverAppBar(
                  backgroundColor: kPrimary,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () {
                      // Define what happens when the button is pressed
                      Navigator.of(context).pop();
                    },
                  ),
                  title: Text(
                    'Edit To-Do List ',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -1.2,
                          color: Colors.black,
                        ),
                  ),
                  centerTitle: false,
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                  floating: true,
                  actions: [
                    IconButton(
                      onPressed: () async {
                        await _todoController
                            .deleteTodo(todoId)
                            .then((value) => Get.back());
                      },
                      icon: const Icon(
                        CupertinoIcons.delete,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 50.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleTextBox(),
                          StartDatePicker(),
                          EndDatePicker(),
                        ]),
                  ),
                ),
              ],
            ),
          ),
          EditButton(todoId: todoId),
        ],
      ),
    );
  }
}
