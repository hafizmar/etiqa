class ApiEndPoints {
  static const String baseUrl = 'http://localhost:8000/api/';
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {
  // post
  final String allTodo = 'todo';
  final String createTodo = 'todo';
  final String updateStatusTodo = 'update-status-todo';
  final String deleteTodo = 'todo';
}
