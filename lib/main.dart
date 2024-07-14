import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'configs/theme.dart';
import 'screens/configs/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Etiqa Test',
      theme: lightTheme(context),
      darkTheme: darkTheme(context),
      initialRoute: '/',
      getPages: [
        //routing
        GetPage(name: '/', page: () => HomeScreen()),
        GetPage(name: '/add-todo', page: () => TodoAdd()),
        GetPage(name: '/edit-todo', page: () => TodoEdit()),
      ],
    );
  }
}
