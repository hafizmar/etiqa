import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../configs/constant.dart';
import '../configs/theme.dart';
import '../controllers/controllers.dart';

class StartDatePicker extends StatelessWidget {
  StartDatePicker({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: Text(
            'Start Date',
            style: TextStyle(
                color: isLightTheme(context) ? Colors.grey[600] : Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Text("${selectedDate.toLocal()}".split(' ')[0]),
            Obx(
              () => Text(
                "${_todoController.startDate.value}".split(' ')[0],
                style: TextStyle(
                  color: isLightTheme(context) ? Colors.black : Colors.white,
                ),
              ),
            ),
            Material(
              shape: const CircleBorder(),
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
                onTap: () => _selectStartDate(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 7.0, vertical: 7.0),
                  child: const Icon(
                    CupertinoIcons.calendar,
                    color: kPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
