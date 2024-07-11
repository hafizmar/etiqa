import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

import '../../configs/constant.dart';
import '../../configs/theme.dart';
import '../../controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  // home controller
  final HomeController _homeController = Get.put(HomeController());

  Future<void> delayLoading() async {
    await Future.delayed(const Duration(seconds: 2), () {
      _homeController.isLoading.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => _homeController.isLoading.value
        ? toDo(context)
        : Scaffold(
            backgroundColor: kAppBarDark,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/etiqa.png',
                    height: 100,
                    width: 100,
                  ),
                  // RotationTransition(
                  //   turns: turnsTween.animate(_animationController),
                  //   child:
                  // ),
                  Obx(
                    () => Text(
                      _homeController.isLoadingString.value,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15.0),
                    ),
                  ),
                ],
              ),
            ),
          ));
  }

  Widget toDo(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('add-todo'),
        backgroundColor: Colors.red,
        child: const Icon(CupertinoIcons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: CustomScrollView(
        physics: Platform.isIOS
            ? AlwaysScrollableScrollPhysics()
            : const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            title: Text(
              'To-Do List',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.2,
                    color: isLightTheme(context) ? Colors.black : Colors.white,
                  ),
            ),
            centerTitle: false,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            floating: true,
            bottom: PreferredSize(
              child: Obx(() {
                return _homeController.isRefresh.value
                    ? GradientProgressIndicator(
                        gradient: Gradients.buildGradient(Alignment.topLeft,
                            Alignment.topRight, [kPrimary, kBubbleDark]),
                        value: 1,
                      )
                    : GradientProgressIndicator(
                        gradient: Gradients.buildGradient(Alignment.topLeft,
                            Alignment.topRight, [kPrimary, kBubbleDark]),
                        value: 1,
                      );
              }),
              preferredSize: const Size.fromHeight(10.0),
            ),
          ),
          CupertinoSliverRefreshControl(
            refreshTriggerPullDistance: 150,
            onRefresh: () async {},
          ),
          // const SliverFillRemaining(
          //   child: Center(child: Text('Nothing to do right now.')),
          // ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(25),
              // padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: kBubbleLight,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 20,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              height: 200,
              width: double.infinity,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: Text(
                        'Automated Testing Script',
                        style: TextStyle(
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
                                child: Text(
                                  'Start Date',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ),
                              Container(
                                child: Text(
                                  '21 Oct 2024',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  'End Date',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ),
                              Container(
                                child: Text(
                                  '23 Oct 2024',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  'Time Left',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ),
                              Container(
                                child: Text(
                                  '23 hrs 22 min',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 5),
                      height: 50,
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
                              SizedBox(width: 10),
                              Container(
                                child: Text(
                                  'Incomplete',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                child: Text(
                                  'Tick if completed',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ),
                              Container(
                                child: Checkbox(
                                  onChanged: ((value) {
                                    value != value;
                                  }),
                                  value: true,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          )),
                      width: double.infinity,
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
