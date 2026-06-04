import 'package:intl/intl.dart';

extension NumberExtensions on num? {
  String formattedAmount([int? decimalDigits]) {
    final NumberFormat numberFormat = NumberFormat.currency(
      locale: "en",
      customPattern: '##,###.##',
      decimalDigits: decimalDigits ?? 2,
    );
    final String amountString = numberFormat.format(this ?? 0);
    return amountString;
  }

  /// Formats a number in compact Instagram-style notation.
  /// e.g. 999 → "999", 1200 → "1.2K", 1500000 → "1.5M", 2000000000 → "2B"
  String get compactFormat {
    final value = (this ?? 0).toDouble();
    if (value >= 1000000000) {
      final result = value / 1000000000;
      return '${_trimTrailingZero(result)}B';
    } else if (value >= 1000000) {
      final result = value / 1000000;
      return '${_trimTrailingZero(result)}M';
    } else if (value >= 1000) {
      final result = value / 1000;
      return '${_trimTrailingZero(result)}K';
    }
    return value.toInt().toString();
  }

  String _trimTrailingZero(double value) {
    final formatted = value.toStringAsFixed(1);
    return formatted.endsWith('.0') ? formatted.split('.').first : formatted;
  }
}

extension DoubleExtensions on double {
  String get decimalFormatAmount {
    if (this % 1 == 0) return toInt().toString();

    final formatted = toStringAsFixed(2);
    if (formatted.endsWith("0")) return toStringAsFixed(1);

    return formatted;
  }
}

extension ThreeFormatExtensions on double {
  String get threeLastDigitFormatAmount {
    if (this % 1 == 0) return toInt().toString();

    final formatted = toStringAsFixed(3);
    if (formatted.endsWith("0")) return toStringAsFixed(1);

    return formatted;
  }
}
