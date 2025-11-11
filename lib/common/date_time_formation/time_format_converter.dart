import 'package:flutter/material.dart';

String formatTimeTo12Hour(TimeOfDay? dateTime) {
  if (dateTime == null) return '';

  int hour = dateTime.hour;
  int minute = dateTime.minute;
  String period = hour >= 12 ? 'PM' : 'AM';

  // Convert to 12-hour format
  if (hour > 12) {
    hour = hour - 12;
  } else if (hour == 0) {
    hour = 12;
  }

  return '$hour : $minute $period';
}

// ============= Usage: ============
// "time": formatTimeTo12Hour(selectedTime),