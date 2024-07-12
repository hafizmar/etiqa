import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'configs/theme.dart';
import 'controllers/controllers.dart';
import 'screens/configs/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Etiqa Test',
      theme: lightTheme(context),
      darkTheme: darkTheme(context),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomeScreen()),
        GetPage(name: '/add-todo', page: () => TodoAdd()),
        GetPage(name: '/edit-todo', page: () => TodoEdit()),
      ],
      initialBinding: BindingsBuilder(() {
        Get.put(UserController());
      }),
    );
  }
}
