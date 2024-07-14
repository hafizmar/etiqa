import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../configs/constant.dart';
import '../../configs/theme.dart';
import '../../controllers/controllers.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // controller
  final HomeController _homeController = Get.put(HomeController());
  final TodoController _todoController = Get.put(TodoController());

  // variable
  late Future<List<Todo>?> _todos;

  // to delay the loading screen to allow the app to load todo list.
  Future<void> delayLoading() async {
    await Future.delayed(const Duration(seconds: 2), () {
      _homeController.isLoadingString.value = 'Fetching todo list...';
    });

    await Future.delayed(const Duration(seconds: 2), () {
      _homeController.isLoading.value = false;
    });
  }

  // load todo list.
  Future<List<Todo>> loadInitData() async {
    var allTodo = await _todoController.todos();
    return allTodo;
  }

  // refresh to do list.
  Future<void> _refreshList() async {
    setState(() {
      _todoController.titleController.text = '';
      _todoController.startDate = DateTime.now().toString().obs;
      _todoController.endDate = DateTime.now().toString().obs;
      _todos = loadInitData();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _todos = loadInitData();
    delayLoading();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => !_homeController.isLoading.value
          ? _buildHomeScreen(context)
          : _buildSplashScreen(),
    );
  }

  // homeScreen widget
  Widget _buildHomeScreen(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () =>
            Get.toNamed('add-todo')!.then((value) => _refreshList()),
        backgroundColor: Colors.red,
        child: const Icon(
          CupertinoIcons.add,
          color: Colors.white,
        ),
      ),
      backgroundColor: isLightTheme(context) ? kScaffold : kScaffoldDark,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
            backgroundColor: kPrimary,
            title: Text(
              'To-Do List',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.2,
                    color: Colors.black,
                  ),
            ),
            centerTitle: false,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            floating: true,
            bottom: PreferredSize(
              child: Container(),
              preferredSize: const Size.fromHeight(10.0),
            ),
          ),
          // Refresh controller
          CupertinoSliverRefreshControl(
            refreshTriggerPullDistance: 150,
            onRefresh: () async {
              _refreshList();
            },
          ),
          // List of todos
          FutureBuilder<List<Todo>?>(
            future: _todos,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                //checking on conntection
                case ConnectionState.waiting:
                  return SliverFillRemaining(
                    child: Center(
                        child: Text(
                      'Loading...',
                      style: TextStyle(
                          color: isLightTheme(context)
                              ? Colors.black
                              : Colors.white),
                    )),
                  );
                case ConnectionState.done:
                default:
                  if (snapshot.hasError) {
                    // if data has error
                    return SliverFillRemaining(
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(CupertinoIcons.exclamationmark_triangle_fill,
                              size: 70.0, color: Colors.yellow[600]),
                          Container(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text('Oppss! Something went wrong.',
                                style: TextStyle(
                                    color: isLightTheme(context)
                                        ? Colors.black
                                        : Colors.white)),
                          ),
                        ],
                      )),
                    );
                  } else if (snapshot.hasData) {
                    // if data has data
                    final todos = snapshot.data;
                    if (todos!.isNotEmpty) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final todo = todos[index];
                          return TodoCard(
                            todo: todo,
                            refresh: _refreshList,
                          );
                        }, childCount: todos.length),
                      );
                    } else {
                      // if something went wrong with the data.
                      return SliverFillRemaining(
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(CupertinoIcons.exclamationmark_triangle_fill,
                                size: 70.0, color: Colors.yellow[600]),
                            Container(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text('Oppss! Something went wrong.',
                                  style: TextStyle(
                                      color: isLightTheme(context)
                                          ? Colors.black
                                          : Colors.white)),
                            ),
                          ],
                        )),
                      );
                    }
                  } else {
                    // if there is no data after connection is ok.
                    return const SliverFillRemaining(
                      child:
                          Center(child: Text('Nothing to do at the moment.')),
                    );
                  }
              }
            },
          )
        ],
      ),
    );
  }

  // splash screen
  Widget _buildSplashScreen() {
    return Scaffold(
      backgroundColor: kAppBarDark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/etiqa_white.png',
              height: 100,
              width: 100,
            ),
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
    );
  }
}
