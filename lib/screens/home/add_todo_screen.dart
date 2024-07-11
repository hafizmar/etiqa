import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../configs/constant.dart';
import '../../configs/theme.dart';
import '../../controllers/controllers.dart';
import '../../widgets/widgets.dart';

class TodoAdd extends StatelessWidget {
  TodoAdd({Key? key}) : super(key: key);

  TodoController _todoController = Get.put(TodoController());

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      // setState(() {
      //   selectedDate = picked;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: Platform.isIOS
            ? AlwaysScrollableScrollPhysics()
            : const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
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
                    color: isLightTheme(context) ? Colors.black : Colors.white,
                  ),
            ),
            centerTitle: false,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            floating: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'To-Do Title',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color:
                            isLightTheme(context) ? kBubbleLight : kBubbleDark,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextField(
                        minLines: 5,
                        maxLines: 10,
                        onChanged: (value) => {},
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
                            color: isLightTheme(context)
                                ? Colors.black
                                : Colors.white),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Start Date',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      child: ElevatedButton(
                        onPressed: () => _selectDate(context),
                        child: const Text('Select date'),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Estimated End Date',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
