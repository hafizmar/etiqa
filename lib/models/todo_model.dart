class Todo {
  final int id;
  final String title;
  final String startDate;
  final String endDate;
  final String createdAt;
  final String createdBy;
  final int status;
  bool isDone;

  Todo({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.createdBy,
    required this.status,
    this.isDone = false,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      createdAt: json['created_at'],
      createdBy: json['created_by'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'start_date': startDate,
      'end_date': endDate,
      'created_at': createdAt,
      'created_by': createdBy,
      'status': status,
    };
  }
}
