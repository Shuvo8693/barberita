import 'package:barberita/common/app_images/app_svg.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barberita/common/app_color/app_colors.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:barberita/common/widgets/custom_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LocationSelectionBottomSheet extends StatefulWidget {
  final String? currentAddress;

  const LocationSelectionBottomSheet({
    super.key,
    this.currentAddress,
  });

  @override
  State<LocationSelectionBottomSheet> createState() => _LocationSelectionBottomSheetState();
}

class _LocationSelectionBottomSheetState extends State<LocationSelectionBottomSheet> {
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController(
      text: widget.currentAddress ?? '112/2 Riyad',
    );
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Set Your Home Location',
            style: GoogleFontStyles.h3(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 24.h),

          // Address Input Field
          CustomTextField(
            controller: _addressController,
            hintText: 'Enter your address',
            fillColor: AppColors.darkJungleGreenBGColor,
            prefixIcon: Padding(
              padding:  EdgeInsets.all(8.0.sp),
              child: SvgPicture.asset(AppSvg.navPinSvg,height: 20.h,),
            ),
          ),

          SizedBox(height: 24.h),

          // Continue Button
          CustomButton(
            onTap: () {
              // Return the address when continue is pressed
              Navigator.pop(context, _addressController.text);
            },
            text: 'Continue',
            textStyle: GoogleFontStyles.h4(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            color: const Color(0xFF55493E),
            borderRadius: 12.r,
            height: 56.h,
          ),

          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}

// Usage Example
void showLocationSelectionBottomSheet(BuildContext context, {String? currentAddress}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => LocationSelectionBottomSheet(
      currentAddress: currentAddress,
    ),
  ).then((address) {
    if (address != null) {
      // Handle the returned address
      print('Selected address: $address');
    }
  });
}