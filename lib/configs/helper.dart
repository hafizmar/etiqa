import 'package:intl/intl.dart';

class HelperFunction {
  HelperFunction();
  List messageArray = [];

  // convert and reformat DateTime and return to string
  String _dateTimeToString(String postDateTimeString) {
    final DateTime postDateTime = DateTime.parse(postDateTimeString);
    String timestamp = '';
    DateFormat dateFormat = DateFormat('d MMM yyyy');
    timestamp = dateFormat.format(postDateTime);

    return timestamp;
  }

  // convert string to DateTime
  DateTime _dateTime(String postDateTimeString) {
    final DateTime postDateTime = DateTime.parse(postDateTimeString);
    return postDateTime;
  }

  String dateTimeToString(dynamic element) => _dateTimeToString(element);
  DateTime dateTime(dynamic element) => _dateTime(element);
}
