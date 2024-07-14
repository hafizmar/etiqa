import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../configs/constant.dart';
import '../../configs/theme.dart';
import '../../controllers/controllers.dart';

class TodoAdd extends StatelessWidget {
  TodoAdd({Key? key}) : super(key: key);

  final TodoController _todoController = Get.put(TodoController());

  final DateTime selectedDate = DateTime.now();

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.parse(_todoController.startDate.value),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      _todoController.startDate.value = picked.toString();
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.parse(_todoController.endDate.value),
        firstDate: DateTime.parse(_todoController.startDate.value),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      _todoController.endDate.value = picked.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () {
                      // Define what happens when the button is pressed
                      Navigator.of(context).pop();
                    },
                  ),
                  title: Text(
                    'Add new To-Do List',
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
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 50.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              'To-Do Title',
                              style: TextStyle(
                                  color: isLightTheme(context)
                                      ? Colors.grey[600]
                                      : Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Obx(() => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              _todoController.isTitleEmpty.value
                                                  ? Colors.red
                                                  : Colors.transparent,
                                          width: 2),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      color: isLightTheme(context)
                                          ? kBubbleLight
                                          : kBubbleDark,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: TextField(
                                      minLines: 5,
                                      maxLines: 10,
                                      onChanged: (value) {
                                        _todoController.isTitleEmpty.value =
                                            false;

                                        _todoController.titleController.text =
                                            value;
                                      },
                                      controller:
                                          _todoController.titleController,
                                      decoration: InputDecoration(
                                        hintText:
                                            'Please key in your To-Do title here',
                                        hintStyle: TextStyle(
                                            color: isLightTheme(context)
                                                ? Colors.grey[500]
                                                : Colors.white,
                                            fontSize: 18.0),
                                        border: InputBorder.none,
                                        errorBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      style: TextStyle(
                                          color: isLightTheme(context)
                                              ? Colors.black
                                              : Colors.white),
                                    ),
                                  ),
                                  _todoController.isTitleEmpty.value
                                      ? const Text(
                                          'To-Do title cannot be empty.',
                                          style: TextStyle(color: Colors.red),
                                        )
                                      : const SizedBox(),
                                ],
                              )),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Text(
                              'Start Date',
                              style: TextStyle(
                                  color: isLightTheme(context)
                                      ? Colors.grey[600]
                                      : Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Text("${selectedDate.toLocal()}".split(' ')[0]),
                              Obx(
                                () => Text(
                                  "${_todoController.startDate.value}"
                                      .split(' ')[0],
                                  style: TextStyle(
                                    color: isLightTheme(context)
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                              Material(
                                shape: const CircleBorder(),
                                child: InkWell(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                  onTap: () => _selectStartDate(context),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7.0, vertical: 7.0),
                                    child: Icon(
                                      CupertinoIcons.calendar,
                                      color: kPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    'Estimated End Date',
                                    style: TextStyle(
                                        color: isLightTheme(context)
                                            ? Colors.grey[600]
                                            : Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Obx(
                                      () => Text(
                                        "${_todoController.endDate.value}"
                                            .split(' ')[0],
                                        style: TextStyle(
                                          color: isLightTheme(context)
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                    Material(
                                      shape: const CircleBorder(),
                                      child: InkWell(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                        onTap: () => _selectEndDate(context),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 7.0, vertical: 7.0),
                                          child: Icon(
                                            CupertinoIcons.calendar,
                                            color: kPrimary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
          Material(
            child: InkWell(
              splashColor: kPrimary,
              onTap: () => createTodo(),
              child: Container(
                padding: const EdgeInsets.only(top: 20.0),
                color: Colors.black87,
                width: double.infinity,
                height: 100,
                child: Text(
                  'Create Now',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void createTodo() async {
    if (_todoController.titleController.text.isEmpty) {
      _todoController.isTitleEmpty.value = true;
    }

    if (_todoController.titleController.text.isNotEmpty) {
      _todoController.createTodo().then((value) => Get.back());
    }
  }
}
