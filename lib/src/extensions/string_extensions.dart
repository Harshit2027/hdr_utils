import 'package:intl/intl.dart';
import 'date_time_extensions.dart';

extension StringExtensions on String {
  DateTime parseUtcDateTime([String format = "yyyy-MM-dd HH:mm:ss"]) {
    var time = DateFormat(
      format,
    ).parseUTC(replaceAll("T", " ").replaceAll("Z", " "));
    return time;
  }

  DateTime parseLocalDateTime([String format = "yyyy-MM-dd HH:mm:ss"]) {
    var time = DateFormat(
      format,
    ).parse(replaceAll("T", " ").replaceAll("Z", " "));
    return time;
  }

  DateTime parseLocalDateTimeDayFormat([
    String format = "EEE, dd MMM yyyy HH:mm:ss 'GMT'",
  ]) {
    var time = DateFormat(format).parseUtc(this);
    return time;
  }

  String parseLocalTime([String format = "hh:mm a"]) {
    String time = DateFormat(
      format,
    ).format(DateTime.parse(this).toLocal()).toLowerCase();
    return time;
  }

  int showAgeByBirthDate([String format = "yyyy-MM-dd HH:mm:ss"]) {
    var time = DateFormat(
      format,
    ).parse(replaceAll("T", " ").replaceAll("Z", " "));
    var now = DateTime.now();
    int age = now.year - time.year;
    if (now.month < time.month ||
        (now.month == time.month && now.day < time.day)) {
      age--;
    }
    return age;
  }

  bool get isSvg {
    return (toLowerCase().endsWith('svg'));
  }

  String obscureEmail([int? length = 3]) {
    if (isEmpty) return this;
    var parts = split('@');
    if (parts.first.length > 3) {
      return "${parts.first.substring(0, length).padRight(parts.first.length, '*')}@${parts.last}";
    }
    return this;
  }

  String toLocalString([String format = "yyyy-MM-dd HH:mm:ss"]) {
    var time = DateTime.parse(this).toLocalString(format);
    return time.toString();
  }

  bool get isImage {
    return (toLowerCase().contains('png') ||
        toLowerCase().contains('jpeg') ||
        toLowerCase().contains('webp') ||
        toLowerCase().contains('jpg'));
  }

  bool get isVideo {
    return (toLowerCase().contains('mov') ||
        toLowerCase().contains('mp4') ||
        toLowerCase().contains('mkv') ||
        toLowerCase().contains('avi'));
  }

  String get capitalize {
    if (length <= 1) return this;
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension NullableStringExtensions on String? {
  bool get isNullOrEmpty => this?.trim().isEmpty ?? true;

  int toInt() {
    return this == null ? 0 : int.tryParse(this!) ?? 0;
  }

  double toDouble() {
    return this == null
        ? 0
        : double.tryParse(this?.replaceAll(RegExp(r'[^0-9.]'), '') ?? "0") ??
              0.0;
  }
}

extension TruncateStringExtensions on String {
  String truncateWithString(int maxLength) {
    return (length <= maxLength) ? this : '${substring(0, maxLength)}...';
  }
}

extension TimeConversionExtensions on String {
  int toMinutes() {
    return ((double.tryParse(this) ?? 0.0) * 60).toInt();
  }
}
