import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

enum LogLevel {
  info(32),
  debug(208),
  error(196),
  success(77);

  final int _color;

  const LogLevel(this._color);
}

class LoggerUtils {
  static const ansiEsc = '\x1B[';
  static const ansiDefault = '${ansiEsc}0m';
  static const _encoder = JsonEncoder.withIndent("  ");

  static File? _logFile;

  /// Optional initialization. MUST be called in main() to support saving to files.
  /// No-op on Web platform.
  static Future<void> init() async {
    if (kIsWeb) return;
    try {
      final dir = await getApplicationDocumentsDirectory();
      final logsDir = Directory("${dir.path}/logs");

      if (!logsDir.existsSync()) logsDir.createSync(recursive: true);

      String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
      _logFile = File("${logsDir.path}/$date.log");

      if (!_logFile!.existsSync()) {
        _logFile!.createSync(recursive: true);
      }
    } catch (e) {
      debugPrint("Failed to initialize file logger: $e");
    }
  }

  static void info(Object? info) => _print(info, LogLevel.info);

  static void debug(Object? info) => _print(info, LogLevel.debug);

  static void error(Object? error) => _print(error, LogLevel.error);

  static void success(Object? info) => _print(info, LogLevel.success);

  static void _print(Object? object, LogLevel logLevel) {
    try {
      if (object is num || object is String || object is bool) {
        log(object.toString(), logLevel);
      } else {
        _encoder
            .convert(object)
            .split("\n")
            .forEach((element) => log(element, logLevel));
      }
    } catch (_) {
      log(object.toString(), logLevel);
    }
  }

  static void log(String content, [LogLevel logLevel = LogLevel.debug]) {
    // Print to console with color
    if (!kIsWeb && (Platform.isIOS || Platform.isMacOS)) {
      debugPrint(content);
    } else {
      debugPrint("${ansiEsc}38;5;${logLevel._color}m$content$ansiDefault");
    }

    // Also save to date-wise file
    _saveToFile(content);
  }

  static void _saveToFile(String text) {
    if (kIsWeb || _logFile == null) return;
    try {
      final time = DateFormat("HH:mm:ss").format(DateTime.now());
      final line = "[$time] $text\n";
      _logFile!.writeAsStringSync(line, mode: FileMode.append, flush: true);
    } catch (e) {
      debugPrint("Error writing log to file: $e");
    }
  }
}

extension LoggerUtilsExtension on Object? {
  void logDebug() => LoggerUtils.debug(this);

  void logError() => LoggerUtils.error(this);

  void logSuccess() => LoggerUtils.success(this);
}
