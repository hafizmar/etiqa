import 'package:get/get.dart';

class Todo {
  final int id;
  final String title;
  final String startDate;
  final String endDate;
  final String createdAt;
  final String status;
  RxBool isDone = false.obs;

  Todo({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.status,
    required this.isDone,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      createdAt: json['created_at'],
      status: json['status'],
      isDone: json['status'] == '1' ? true.obs : false.obs,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'start_date': startDate,
      'end_date': endDate,
      'created_at': createdAt,
      'status': status,
    };
  }
}
