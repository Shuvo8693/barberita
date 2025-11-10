import 'package:barberita/app/modules/book_appointment/widgets/custom_info_container.dart';
import 'package:barberita/app/modules/booking/controllers/booking_status_controller.dart';
import 'package:barberita/app/modules/hairdresser_details/controllers/booking_controller.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
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
 final  BookingController _bookingController = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'Book Appointment',),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Select Date Section
            Text(
              'See All Bookings',
              style: GoogleFontStyles.h5(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2E),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text('Tap to see this barber bookings',
                      style: GoogleFontStyles.h5(
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.book_outlined,
                    color: Colors.white.withOpacity(0.7),
                    size: 24.sp,
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            // Select Date Section
            Text(
              'Select Date',
              style: GoogleFontStyles.h5(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
           //====== Date picker ========

            CustomInfoContainer(
              onTap: (){
                DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  minTime: DateTime.now(),
                  maxTime: DateTime.now().add(const Duration(days: 365)),
                  currentTime: _bookingController.selectedDate ?? DateTime.now(),
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
                      _bookingController.selectedDate = date;
                    });

                  },
                );
              },
                text: _bookingController.selectedDate != null
                    ? DateFormat('dd/MM/yyyy').format(_bookingController.selectedDate!)
                    : '15/12/2025', icon: Icons.calendar_month,
              textColor: _bookingController.selectedDate != null
                  ? Colors.white
                  : Colors.white.withOpacity(0.5),
            ),

            /*GestureDetector(
              onTap: () {
                DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  minTime: DateTime.now(),
                  maxTime: DateTime.now().add(const Duration(days: 365)),
                  currentTime: _bookingController.selectedDate ?? DateTime.now(),
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
                      _bookingController.selectedDate = date;
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
                        _bookingController.selectedDate != null
                            ? DateFormat('dd/MM/yyyy').format(_bookingController.selectedDate!)
                            : '15/12/2025',
                        style: GoogleFontStyles.h5(
                          color: _bookingController.selectedDate != null
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
            ),*/

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
            //====== Time picker ========
            CustomInfoContainer(
              onTap: (){
                DatePicker.showTimePicker(
                  context,
                  showTitleActions: true,
                  currentTime: _bookingController.selectedTime != null
                      ? DateTime(2023, 1, 1, _bookingController.selectedTime!.hour, _bookingController.selectedTime!.minute)
                      : DateTime(2023, 1, 1, 10, 0),
                  locale: LocaleType.en,
                  theme: const DatePickerTheme(
                    backgroundColor: Color(0xFF2C2C2E),
                    itemStyle: TextStyle(color: Colors.white, fontSize: 18),
                    doneStyle: TextStyle(
                      color: Color(0xFFE6C4A3),
                      fontWeight: FontWeight.w600,
                    ),
                    cancelStyle: TextStyle(color: Colors.grey),
                  ),
                  onConfirm: (time) {
                    setState(() {
                      _bookingController.selectedTime = TimeOfDay(hour: time.hour, minute: time.minute);
                    });
                  },
                );
              },
              text:  _bookingController.selectedTime != null
                  ? _bookingController.selectedTime!.format(context)
                  : '10:04AM - 12:00PM',
              textColor: _bookingController.selectedTime != null
                  ? Colors.white
                  : Colors.white.withOpacity(0.5),
              icon: Icons.access_time,
            ),

           /* GestureDetector(
              onTap: () {
                DatePicker.showTimePicker(
                  context,
                  showTitleActions: true,
                  currentTime: _bookingController.selectedTime != null
                      ? DateTime(2023, 1, 1, _bookingController.selectedTime!.hour, _bookingController.selectedTime!.minute)
                      : DateTime(2023, 1, 1, 10, 0),
                  locale: LocaleType.en,
                  theme: const DatePickerTheme(
                    backgroundColor: Color(0xFF2C2C2E),
                    itemStyle: TextStyle(color: Colors.white, fontSize: 18),
                    doneStyle: TextStyle(
                      color: Color(0xFFE6C4A3),
                      fontWeight: FontWeight.w600,
                    ),
                    cancelStyle: TextStyle(color: Colors.grey),
                  ),
                   onConfirm: (time) {
                    setState(() {
                      _bookingController.selectedTime = TimeOfDay(hour: time.hour, minute: time.minute);
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
                        _bookingController.selectedTime != null
                            ? _bookingController.selectedTime!.format(context)
                            : '10:04AM - 12:00PM',
                        style: GoogleFontStyles.h5(
                          color: _bookingController.selectedTime != null
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
            ),*/

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
           // =============== Location selection bottom sheet ==============
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
                        _bookingController.selectedAddress ?? 'Set Your Current Location',
                        style: GoogleFontStyles.h5(
                          color: _bookingController.selectedAddress != null
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

            // ===== Continue Button =================
            Obx(() {
              return CustomButton(
                 loading: _bookingController.isLoadingBooking.value,
                onTap: () async {
                  if (_bookingController.selectedDate != null && _bookingController.selectedTime != null && _bookingController.selectedAddress !=null) {
                  await  _bookingController.addBooking();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select date, time & address'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                text: 'Book Now',
              );
             }
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
                  onTap: () async{
                    final result = await Get.toNamed(Routes.LOCATIONSELECTORMAP);
                    print(result);
                    _bookingController.currentLocation = result['latLng'];
                    _bookingController.selectedAddress = result['address'];
                    setState(() {});
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
                  onTap: () async {
                    final result = await Get.toNamed(Routes.LOCATIONSELECTORMAP);
                    print(result);
                    _bookingController.currentLocation = result['latLng'];
                    _bookingController.selectedAddress = result['address'];
                    setState(() {});
                    
                    
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
          'Your appointment has been successfully booked for ${_bookingController.selectedDate != null ? DateFormat('dd/MM/yyyy').format(_bookingController.selectedDate!) : ''} at ${_bookingController.selectedTime?.format(context) ?? ''}',
          style: GoogleFontStyles.h5(color: Colors.white.withOpacity(0.8)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.toNamed(Routes.BOOKING_MANAGEMENT);
              Navigator.pop(context);

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