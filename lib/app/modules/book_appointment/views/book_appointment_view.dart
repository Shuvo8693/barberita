import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/app_color/app_colors.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:barberita/common/widgets/custom_button.dart';

class BookAppointmentView extends StatefulWidget {
  const BookAppointmentView({super.key});

  @override
  State<BookAppointmentView> createState() => _BookAppointmentViewState();
}

class _BookAppointmentViewState extends State<BookAppointmentView> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? selectedAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkJungleGreenBGColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20.sp,
          ),
        ),
        title: Text(
          'Book Appointment',
          style: GoogleFontStyles.h4(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Select Date Section
            Text(
              'Select Date',
              style: GoogleFontStyles.h5(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),

            GestureDetector(
              onTap: () {
                DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  minTime: DateTime.now(),
                  maxTime: DateTime.now().add(const Duration(days: 365)),
                  currentTime: selectedDate ?? DateTime.now(),
                  locale: LocaleType.en,
                  theme: const DatePickerTheme(
                    backgroundColor: Color(0xFF2C2C2E),
                    itemStyle: TextStyle(color: Colors.white, fontSize: 18),
                    doneStyle: TextStyle(
                      color: Color(0xFFE6C4A3),
                      fontWeight: FontWeight.w600,
                    ),
                    cancelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  onConfirm: (date) {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                );
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2E),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        selectedDate != null
                            ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                            : '15/12/2023',
                        style: GoogleFontStyles.h5(
                          color: selectedDate != null
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.calendar_month,
                      color: Colors.white.withOpacity(0.7),
                      size: 24.sp,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // Select Time Section
            Text(
              'Select Time',
              style: GoogleFontStyles.h5(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),

            GestureDetector(
              onTap: () {
                DatePicker.showTimePicker(
                  context,
                  showTitleActions: true,
                  currentTime: selectedTime != null
                      ? DateTime(2023, 1, 1, selectedTime!.hour, selectedTime!.minute)
                      : DateTime(2023, 1, 1, 10, 0),
                  locale: LocaleType.en,
                  theme: const DatePickerTheme(
                    backgroundColor: Color(0xFF2C2C2E),
                    itemStyle: TextStyle(color: Colors.white, fontSize: 18),
                    doneStyle: TextStyle(
                      color: Color(0xFFE6C4A3),
                      fontWeight: FontWeight.w600,
                    ),
                    cancelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  onConfirm: (time) {
                    setState(() {
                      selectedTime = TimeOfDay(hour: time.hour, minute: time.minute);
                    });
                  },
                );
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2E),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        selectedTime != null
                            ? selectedTime!.format(context)
                            : '10:04AM - 12:00PM',
                        style: GoogleFontStyles.h5(
                          color: selectedTime != null
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.access_time,
                      color: Colors.white.withOpacity(0.7),
                      size: 24.sp,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // Address Section
            Text(
              'Address',
              style: GoogleFontStyles.h5(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),

            GestureDetector(
              onTap: () {
                // Handle location selection
                _showLocationBottomSheet();
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2E),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.white.withOpacity(0.7),
                      size: 24.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        selectedAddress ?? 'Set Your Current Location',
                        style: GoogleFontStyles.h5(
                          color: selectedAddress != null
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // Continue Button
            CustomButton(
              onTap: () {
                if (selectedDate != null && selectedTime != null) {
                  // Handle appointment booking
                  _bookAppointment();
                } else {
                  // Show validation message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select date and time'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              text: 'Continue',
            ),

            SizedBox(height: 60.h),
          ],
        ),
      ),
    );
  }

  void _showLocationBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2C2C2E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return SafeArea(
          child: Container(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Location',
                  style: GoogleFontStyles.h4(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20.h),

                ListTile(
                  leading: Icon(
                    Icons.my_location,
                    color: const Color(0xFFE6C4A3),
                  ),
                  title: Text(
                    'Use Current Location',
                    style: GoogleFontStyles.h5(color: Colors.white),
                  ),
                  onTap: () {
                    // setState(() {
                    //   selectedAddress = 'Current Location';
                    // });
                    // Navigator.pop(context);
                    Get.toNamed(Routes.LOCATIONSELECTORMAP);
                  },
                ),

                ListTile(
                  leading: Icon(
                    Icons.location_on,
                    color: const Color(0xFFE6C4A3),
                  ),
                  title: Text(
                    'Choose on Map',
                    style: GoogleFontStyles.h5(color: Colors.white),
                  ),
                  onTap: () {
                    // setState(() {
                    //   selectedAddress = '123 Main Street, City';
                    // });
                    // Navigator.pop(context);
                    Get.toNamed(Routes.LOCATIONSELECTORMAP);
                  },
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      },
    );
  }

  void _bookAppointment() {
    // Handle booking logic here
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2E),
        title: Text(
          'Appointment Booked!',
          style: GoogleFontStyles.h4(color: Colors.white),
        ),
        content: Text(
          'Your appointment has been successfully booked for ${selectedDate != null ? DateFormat('dd/MM/yyyy').format(selectedDate!) : ''} at ${selectedTime?.format(context) ?? ''}',
          style: GoogleFontStyles.h5(color: Colors.white.withOpacity(0.8)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text(
              'OK',
              style: GoogleFontStyles.h5(
                color: const Color(0xFFE6C4A3),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}