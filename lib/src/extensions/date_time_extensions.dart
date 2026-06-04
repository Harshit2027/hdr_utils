import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String toLocalString([String format = "yyyy-MM-dd HH:mm:ss"]) {
    var strDate = DateFormat(format).format(toLocal());
    return strDate;
  }

  String toUtcString([String format = "dd MMM yyyy hh:mm a"]) {
    var strDate = DateFormat(format).format(toUtc());
    return strDate;
  }

  bool get isToday {
    var now = DateTime.now();
    return day == now.day && month == now.month && year == now.year;
  }

  DateTime toDate() {
    return DateTime(year, month, day);
  }

  String get timeAgoLabel {
    final DateTime date = DateTime(year, month, day, hour, minute);
    final diff = DateTime.now().difference(date);

    if (diff.inMinutes < 1) {
      return "Just Now";
    } else if (diff.inHours < 1) {
      return "${diff.inMinutes} min ago";
    } else if (diff.inDays < 1) {
      return "${diff.inHours} hrs ago";
    } else if (diff.inDays < 30) {
      return "${diff.inDays} days ago";
    } else {
      return toLocalString("dd MMM yyyy");
    }
  }
}
