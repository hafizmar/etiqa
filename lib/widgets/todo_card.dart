import 'package:date_count_down/date_count_down.dart';
import 'package:etiqa/configs/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../configs/constant.dart';
import '../controllers/controllers.dart';
import '../models/models.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  final VoidCallback refresh;

  TodoCard({
    Key? key,
    required this.todo,
    required this.refresh,
  }) : super(key: key);

  final TodoController _todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      // padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kScaffold,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 20,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      height: 200,
      width: double.infinity,
      child: Material(
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        child: InkWell(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          onTap: () => openDetail(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Text(
                    todo.title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: const Text(
                              'Start Date',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ),
                          Container(
                            child: Text(
                              HelperFunction().dateTimeToString(todo.startDate),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: const Text(
                              'End Date',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ),
                          Container(
                            child: Text(
                              HelperFunction().dateTimeToString(todo.endDate),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: const Text(
                              'Time Left',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ),
                          CountDownText(
                            due: HelperFunction().dateTime(todo.endDate),
                            finishedText: 'Expired',
                            showLabel: true,
                            longDateName: false,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 5),
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      )),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Text(
                              'Status',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Obx(
                            () => Container(
                              child: Text(
                                todo.isDone.isTrue ? 'Completed' : 'Incomplete',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            child: const Text(
                              'Tick if completed',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                          Obx(
                            () => Container(
                              child: Checkbox(
                                onChanged: ((value) async {
                                  updateStatus();
                                  todo.isDone.value = !todo.isDone.value;
                                }),
                                value: todo.isDone.value,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  void openDetail() {
    Get.toNamed('edit-todo', arguments: [
      todo.id.toString(),
      todo.title,
      todo.startDate,
      todo.endDate
    ])!
        .then((value) {
      refresh();
    });
  }

  void updateStatus() async {
    await _todoController.updateTodoStatus(
        todo.id.toString(), todo.isDone.value ? 0 : 1);
  }
}
