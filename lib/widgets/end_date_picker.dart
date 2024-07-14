import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../configs/constant.dart';
import '../configs/theme.dart';
import '../controllers/controllers.dart';

class EndDatePicker extends StatelessWidget {
  EndDatePicker({super.key});

  final TodoController _todoController = Get.put(TodoController());
  final DateTime selectedDate = DateTime.now();

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
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              'Estimated End Date',
              style: TextStyle(
                  color:
                      isLightTheme(context) ? Colors.grey[600] : Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Text(
                  "${_todoController.endDate.value}".split(' ')[0],
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
                  onTap: () => _selectEndDate(context),
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
      ),
    );
  }
}
