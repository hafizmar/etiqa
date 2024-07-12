import 'package:intl/intl.dart';

class HelperFunction {
  HelperFunction();
  List messageArray = [];

  String _dateTimeToString(String postDateTimeString) {
    final DateTime postDateTime = DateTime.parse(postDateTimeString);
    String timestamp = '';
    DateFormat dateFormat = DateFormat('d MMM yyyy');
    timestamp = dateFormat.format(postDateTime);

    return timestamp;
  }

  DateTime _dateTime(String postDateTimeString) {
    final DateTime postDateTime = DateTime.parse(postDateTimeString);

    return postDateTime;
  }

  String dateTimeToString(dynamic element) => _dateTimeToString(element);
  DateTime dateTime(dynamic element) => _dateTime(element);

  String _getInitials(String username) {
    List<String> names = username.split(" ");
    String initials = "";
    int numWords = 1;

    if (numWords < names.length) {
      for (var i = 0; i < 2; i++) {
        initials += names[i].isEmpty ? names[i + 1][0] : names[i][0];
      }
    } else if (numWords == names.length && username != '') {
      for (var i = 0; i < 1; i++) {
        initials += '${names[i][0]}';
      }
    } else if (numWords == names.length && username == '') {
      initials = '';
    }
    return initials.toUpperCase();
  }

  String getInitials(dynamic element) => _getInitials(element);
}
