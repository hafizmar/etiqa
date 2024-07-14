import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../configs/constant.dart';
import '../../widgets/widgets.dart';

class TodoAdd extends StatelessWidget {
  TodoAdd({Key? key}) : super(key: key);

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
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
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
                          TitleTextBox(),
                          StartDatePicker(),
                          EndDatePicker(),
                        ]),
                  ),
                ),
              ],
            ),
          ),
          CreateButton(),
        ],
      ),
    );
  }
}
