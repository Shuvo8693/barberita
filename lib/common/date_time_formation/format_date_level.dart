
import 'package:intl/intl.dart';

String formatDateLabel(String dateString) {
  try {
    // Parse "30-11-2025" format (dd-MM-yyyy)
  bool isSlash = dateString.contains('/');
    DateTime date = DateFormat(isSlash?'dd/MM/yyyy':'dd-MM-yyyy').parse(dateString);
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime tomorrow = today.add(Duration(days: 1));
    DateTime yesterday = today.subtract(Duration(days: 1));
    DateTime dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == today) {
      return "Today";
    } else if (dateOnly == tomorrow) {
      return "Tomorrow";
    } else if (dateOnly == yesterday) {
      return "Yesterday";
    } else {
      // Return formatted date like "Nov 30, 2025"
      return DateFormat('MMM dd, yyyy').format(date);
    }
  } catch (e) {
    print('Date parsing error: $e');
    return dateString; // Return original if parsing fails
  }
}