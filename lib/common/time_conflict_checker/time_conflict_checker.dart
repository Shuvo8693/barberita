// Check if selected date and time conflicts with booked slots
import 'package:barberita/app/modules/hairdresser_details/model/booked_model.dart';

Map<String, dynamic> checkTimeConflict(
    DateTime? selectedDateTime,
    List<BookedData> bookedSlots,
    ){
  if (selectedDateTime == null) {
    return {'hasError': false, 'errorMessage': null};
  }

  try {
    // Selected time slot: selectedDateTime to selectedDateTime + 1 hour
    DateTime selectedEndTime = selectedDateTime.add(Duration(hours: 2));

    // Check each booked slot for conflicts (only accepted bookings)
    for (var slot in bookedSlots) {
      if (slot.status != 'accepted') continue;

      // Parse booked date (format: "22-11-2025")
      DateTime bookedDate = _parseApiDate(slot.date??'');

      // Only check slots on the same date
      if (!_isSameDate(selectedDateTime, bookedDate)) continue;

      // Parse booked time (format: "19 : 6 PM")
      DateTime bookedStartTime = _parseApiDateTime(slot.date!, slot.time??'');
      DateTime bookedEndTime = bookedStartTime.add(Duration(hours: 1));

      // Check for overlap
      bool hasConflict = (selectedDateTime.isBefore(bookedEndTime) && selectedEndTime.isAfter(bookedStartTime));

      if (hasConflict) {
        // Format the conflicting time for display
        String conflictTime = _formatDisplayTime(slot.time??'');
        return {
          'hasError': true,
          'errorMessage':
          'This time slot conflicts with an existing booking at $conflictTime. Service requires 2 hour.'
        };
      }
    }

    return {'hasError': false, 'errorMessage': null};
  } catch (e) {
    print('Error checking time conflict: $e');
    return {'hasError': false, 'errorMessage': null};
  }
}

// Parse API date format: "22-11-2025" to DateTime
DateTime _parseApiDate(String dateString) {
  List<String> parts = dateString.split('-');
  int day = int.parse(parts[0]);
  int month = int.parse(parts[1]);
  int year = int.parse(parts[2]);
  return DateTime(year, month, day);
}

// Parse API date and time: "22-11-2025" + "19 : 6 PM" to DateTime
DateTime _parseApiDateTime(String dateString, String timeString) {
  DateTime date = _parseApiDate(dateString);

  // Parse time: "19 : 6 PM" format
  timeString = timeString.replaceAll(' ', ''); // Remove all spaces: "19:6PM"

  // Split by colon
  List<String> parts = timeString.split(':');
  int hour = int.parse(parts[0]);

  // Extract minutes and period (AM/PM)
  String minuteAndPeriod = parts[1]; // "6PM"
  String period = minuteAndPeriod.contains('PM') ? 'PM' : 'AM';
  int minute = int.parse(minuteAndPeriod.replaceAll(RegExp(r'[APM]'), ''));

  // Convert to 24-hour format
  if (period == 'PM' && hour != 12) {
    hour += 12;  // 3 + 12 = 15 [24 hr format]
  } else if (period == 'AM' && hour == 12) {
    hour = 0;  // 12 am time = 0 [24 hr format]
  }

  return DateTime(date.year, date.month, date.day, hour, minute);
}

// Format API time for display: "19 : 6 PM" -> "7:06 PM"
String _formatDisplayTime(String timeString) {
  try {
    timeString = timeString.replaceAll(' ', '');
    List<String> parts = timeString.split(':');
    int hour = int.parse(parts[0]);
    String minuteAndPeriod = parts[1];
    String period = minuteAndPeriod.contains('PM') ? 'PM' : 'AM';
    int minute = int.parse(minuteAndPeriod.replaceAll(RegExp(r'[APM]'), ''));

    // Convert to 12-hour format for display
    if (hour > 12) {
      hour -= 12;
    } else if (hour == 0) {
      hour = 12;
    }

    return '${hour}:${minute.toString().padLeft(2, '0')} $period';
  } catch (e) {
    return timeString;
  }
}

// Helper: Check if two dates are the same day
bool _isSameDate(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

//=============== Usage ============


/*// Your selected DateTime from picker
DateTime selectedDateTime = DateTime(2025, 11, 11, 19, 2, 0); // 2025-11-11 19:02:00

// Booked slots from API
List<Map<String, dynamic>> bookedSlots = [
  {
    "date": "22-11-2025",
    "time": "19 : 6 PM",
    "status": "accepted",
    "bookingGroupId": "1c1ceca3"
  },
  {
    "date": "11-11-2025",
    "time": "19 : 2 PM",
    "status": "accepted",
    "bookingGroupId": "07c7c7f7"
  }
];

// Check conflict
var result = checkTimeConflict(selectedDateTime, bookedSlots);

print(result['hasError']); // true or false
print(result['errorMessage']); // Conflict message or null

// In your widget
onConfirm: (time) {
  print(time); // 2025-11-11 19:02:00.000

  var conflictCheck = checkTimeConflict(time, bookedSlots);

  if (conflictCheck['hasError']) {
    // Show error
    Get.snackbar('Conflict', conflictCheck['errorMessage']);
  } else {
    // Proceed with booking
    setState(() {
      _bookingController.selectedDateTime = time;
    });
  }
}*/