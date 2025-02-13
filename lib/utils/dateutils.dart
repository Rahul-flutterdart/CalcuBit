import 'package:intl/intl.dart';

class DateUtilsHelper {
  static String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String formatReadableDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }
}