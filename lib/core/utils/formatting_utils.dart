import 'package:intl/intl.dart';

class FormattingUtils {
  static String formatDate(String dateString, {String format = 'MMM d, y'}) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat(format).format(date);
    } catch (e) {
      return dateString;
    }
  }

  static String formatTime(String timeString, {String format = 'HH:mm'}) {
    try {
      final time = DateTime.parse(timeString);
      return DateFormat(format).format(time);
    } catch (e) {
      return timeString;
    }
  }

  static String formatDateTime(String dateTimeString,
      {String format = 'MMM d, y HH:mm'}) {
    try {
      final dateTime = DateTime.parse(dateTimeString);
      return DateFormat(format).format(dateTime);
    } catch (e) {
      return dateTimeString;
    }
  }

  static String formatScore(int? home, int? away) {
    if (home == null || away == null) {
      return '-';
    }
    return '$home - $away';
  }

  static String formatPercentage(num value, {bool withSymbol = true}) {
    final percent = (value * 100).toStringAsFixed(1);
    return withSymbol ? '$percent%' : percent;
  }

  static String formatMoney(num amount,
      {String currency = '€', bool currencyFirst = true}) {
    final formatted = NumberFormat.currency(
      symbol: currency,
      decimalDigits: 0,
    ).format(amount);

    return currencyFirst
        ? formatted
        : formatted.replaceAll(currency, '') + currency;
  }
}
