import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class CustomPhoneField extends StatelessWidget {
  final TextEditingController? controller;
  final String initialCountry;
  final double height;
  final double width;
  final Function(PhoneNumber)? onChanged;
  final Function(Country)? onCountryChanged;

  const CustomPhoneField({
    super.key,
    this.controller,
    this.initialCountry = 'BD',
    this.onChanged,
    this.onCountryChanged,
     this.height = 20,
     this.width = 12,
  });

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Enter Your Phone Number',
        contentPadding: EdgeInsets.symmetric(vertical: height, horizontal: width),
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.5),
        ),
        fillColor: Colors.transparent,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
      style: const TextStyle(color: Colors.white),
      dropdownTextStyle: const TextStyle(color: Colors.white),
      initialCountryCode: initialCountry,
      onChanged: onChanged,
      onCountryChanged: onCountryChanged,
    );
  }
}
