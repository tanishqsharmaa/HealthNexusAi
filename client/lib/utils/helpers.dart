import 'package:intl/intl.dart';

class Helpers {
  /// Format a date string to a readable format
  /// Example: `2025-04-27` -> `Apr 27, 2025`
  static String formatDate(String date, {String format = 'MMM dd, yyyy'}) {
    try {
      final DateTime parsedDate = DateTime.parse(date);
      return DateFormat(format).format(parsedDate);
    } catch (e) {
      return 'Invalid date';
    }
  }

  /// Format a DateTime object to a specified format
  static String formatDateTime(DateTime dateTime, {String format = 'MMM dd, yyyy hh:mm a'}) {
    return DateFormat(format).format(dateTime);
  }

  /// Convert a string to Title Case
  /// Example: `hello world` -> `Hello World`
  static String toTitleCase(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map((word) {
      if (word.trim().isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  /// Validate if a string is a valid URL
  static bool isValidUrl(String url) {
    final Uri? uri = Uri.tryParse(url);
    return uri != null && (uri.isScheme('http') || uri.isScheme('https'));
  }

  /// Calculate the difference in days between two dates
  static int calculateDateDifference(String startDate, String endDate) {
    try {
      final DateTime start = DateTime.parse(startDate);
      final DateTime end = DateTime.parse(endDate);
      return end.difference(start).inDays;
    } catch (e) {
      return 0;
    }
  }

  /// Capitalize the first letter of a string
  /// Example: `hello` -> `Hello`
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  /// Convert seconds to a readable time format (HH:mm:ss)
  /// Example: `3661` -> `01:01:01`
  static String formatDuration(int seconds) {
    final int hours = seconds ~/ 3600;
    final int minutes = (seconds % 3600) ~/ 60;
    final int secs = seconds % 60;
    return [if (hours > 0) hours, minutes, secs].map((val) => val.toString().padLeft(2, '0')).join(':');
  }

  /// Truncate a string to a specific length, adding '...' if truncated
  /// Example: `Hello, world!` -> `Hello...` (if maxLength is 5)
  static String truncateString(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }
}