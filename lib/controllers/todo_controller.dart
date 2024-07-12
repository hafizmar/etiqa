import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../configs/api_endpoints.dart';
import '../configs/theme.dart';
import '../models/models.dart';

class TodoController extends GetxController {
  TextEditingController titleController = TextEditingController();
  RxString startDate = DateTime.now().toString().obs;
  RxString endDate = DateTime.now().toString().obs;
  RxBool isTitleEmpty = false.obs;
  RxList<Todo> rxTodoList = RxList<Todo>();

  Future<List<Todo>> todos() async {
    var headers = {
      'Accept': 'application/json',
    };

    var url =
        Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.allTodo);

    try {
      http.Response response = await http.get(url, headers: headers);

      print('url : ${url}');
      print('response : ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['success'] == true) {
          final List<dynamic> todosJson = responseData['data'];
          // print(todosJson);
          rxTodoList
              .assignAll(todosJson.map((json) => Todo.fromJson(json)).toList());
          return todosJson.map((json) => Todo.fromJson(json)).toList();
        } else if (responseData['success'] == false) {
          throw responseData['message'];
        } else {
          throw responseData['message'];
        }
      } else {
        throw response.statusCode == 0
            ? "Unknown Error Occured"
            : response.statusCode;
      }
    } catch (error) {
      // Get.snackbar('Error', error.toString());
      // Get.back();
      // throw 0;

      throw showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: '',
        barrierColor: Colors.black38,
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (ctx, anim1, anim2) => Theme(
          data: isLightTheme(ctx) ? ThemeData.light() : ThemeData.dark(),
          child: CupertinoAlertDialog(
            title: Text('ERROR'),
            content: error == ''
                ? const Text('Something went wrong.')
                : Text('Error ' +
                    error.toString() +
                    '. Please contact administrator.'),
            actions: <Widget>[
              // CupertinoDialogAction(
              //   child: Text('Cancel'),
              //   onPressed: () => Navigator.of(ctx).pop(false),
              // ),
              CupertinoDialogAction(
                child: Text('Okay'),
                onPressed: () => Get.back(),
              ),
            ],
          ),
        ),
        transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
          child: FadeTransition(
            child: child,
            opacity: anim1,
          ),
        ),
        context: Get.context!,
      );
    }
  }

  Future<void> createTodo() async {
    var url =
        Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.createTodo);

    try {
      var headers = {
        'Accept': 'application/json',
      };

      Map body = {
        'title': titleController.text.trim(),
        'start_date': startDate.value,
        'end_date': endDate.value,
      };

      http.Response response =
          await http.post(url, body: body, headers: headers);

      print('url : $url');
      print('response : ${response.statusCode}');
    } catch (e) {
      Get.snackbar('Error', e.toString());
      Get.back();
    }
  }

  Future<void> updateTodoStatus(String todoId, int status) async {
    print('update-status : ' + todoId.toString() + ' | ' + status.toString());
    var url = Uri.parse(ApiEndPoints.baseUrl +
        ApiEndPoints.authEndPoints.updateStatusTodo +
        '/' +
        todoId);

    try {
      var headers = {
        'Accept': 'application/json',
      };

      Map body = {
        'status': status.toString(),
      };

      http.Response response =
          await http.put(url, body: body, headers: headers);

      print('url-update : $url');
      print('response-update : ${response.statusCode}');
    } catch (error) {
      // Get.snackbar('Error', e.toString());
      // Get.back();

      throw showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: '',
        barrierColor: Colors.black38,
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (ctx, anim1, anim2) => Theme(
          data: isLightTheme(ctx) ? ThemeData.light() : ThemeData.dark(),
          child: CupertinoAlertDialog(
            title: Text('ERROR'),
            content: error == ''
                ? const Text('Something went wrong.')
                : Text('Error ' +
                    error.toString() +
                    '. Please contact administrator.'),
            actions: <Widget>[
              // CupertinoDialogAction(
              //   child: Text('Cancel'),
              //   onPressed: () => Navigator.of(ctx).pop(false),
              // ),
              CupertinoDialogAction(
                child: Text('Okay'),
                onPressed: () => Get.back(),
              ),
            ],
          ),
        ),
        transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
          child: FadeTransition(
            child: child,
            opacity: anim1,
          ),
        ),
        context: Get.context!,
      );
    }
  }

  Future<void> updateTodo(String todoId) async {
    var url = Uri.parse(ApiEndPoints.baseUrl +
        ApiEndPoints.authEndPoints.createTodo +
        '/' +
        todoId);

    try {
      var headers = {
        'Accept': 'application/json',
      };

      Map body = {
        'title': titleController.text.trim(),
        'start_date': startDate.value,
        'end_date': endDate.value,
      };

      http.Response response =
          await http.put(url, body: body, headers: headers);

      print('url : $url');
      print('response : ${response.statusCode}');
    } catch (e) {
      Get.snackbar('Error', e.toString());
      Get.back();
    }
  }

  Future<void> deleteTodo(String todoId) async {
    var url = Uri.parse(ApiEndPoints.baseUrl +
        ApiEndPoints.authEndPoints.deleteTodo +
        '/' +
        todoId);

    try {
      var headers = {
        'Accept': 'application/json',
      };

      // Map body = {
      //   'title': titleController.text.trim(),
      //   'start_date': startDate.value,
      //   'end_date': endDate.value,
      // };

      http.Response response = await http.delete(url, headers: headers);

      print('url : $url');
      print('response : ${response.statusCode}');
    } catch (e) {
      Get.snackbar('Error', e.toString());
      Get.back();
    }
  }
}
