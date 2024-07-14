class ApiEndPoints {
  // base url for the API
  static const String baseUrl = 'https://www.hafizmar.com/api/';
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {
  // fetch all todo list
  final String allTodo = 'todo';
  // create todo item endpoint
  final String createTodo = 'todo';
  // update status todo item endpoint
  final String updateStatusTodo = 'update-status-todo';
  // delete todo item endpoint
  final String deleteTodo = 'todo';
}
