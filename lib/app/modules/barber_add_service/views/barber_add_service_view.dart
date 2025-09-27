import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barberita/common/app_color/app_colors.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:barberita/common/widgets/custom_text_field.dart';


// Add Service Screen
class BarberAddServiceView extends StatefulWidget {
  const BarberAddServiceView({super.key});

  @override
  State<BarberAddServiceView> createState() => _BarberAddServiceViewState();
}

class _BarberAddServiceViewState extends State<BarberAddServiceView> {
  final TextEditingController _serviceNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Add Service',),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Service Images
              Row(
                children: [
                  _buildImageContainer('assets/images/service_add1.jpg', true),
                  SizedBox(width: 12.w),
                  _buildImageContainer('assets/images/service_add2.jpg', false),
                ],
              ),

              SizedBox(height: 32.h),

              // Service Name Field
              _buildFormField('Service Name', _serviceNameController, 'e.g. Hair cut'),

              SizedBox(height: 20.h),

              // Price Field
              _buildFormField('Price', _priceController, 'e.g. \$15 - \$500'),

              SizedBox(height: 20.h),

              // Description Field
              _buildDescriptionField(),

              SizedBox(height: 40.h),

              // Save Button
              CustomButton(
                onTap: () {
                  // Handle save service
                  Navigator.pop(context);
                },
                text: 'Save',
                textStyle: GoogleFontStyles.h4(color: Colors.white, fontWeight: FontWeight.w600),
                color: const Color(0xFF55493E),
                borderRadius: 12.r,
                height: 56.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageContainer(String imagePath, bool hasCloseButton) {
    return Expanded(
      child: Stack(
        children: [
          Container(
            height: 120.h,
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C2E),
              borderRadius: BorderRadius.circular(12.r),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (hasCloseButton)
            Positioned(
              top: 8.h,
              right: 8.w,
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: Colors.white, size: 16.sp),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, TextEditingController controller, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFontStyles.h6(color: Colors.white.withOpacity(0.7))),
        SizedBox(height: 8.h),
        CustomTextField(
          controller: controller,
          hintText: hint,
          fillColor: const Color(0xFF2C2C2E),
          hintStyle: GoogleFontStyles.h5(color: Colors.white.withOpacity(0.5)),
        ),
      ],
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: GoogleFontStyles.h6(color: Colors.white.withOpacity(0.7))),
        SizedBox(height: 8.h),
        Container(
          height: 100.h,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2E),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: TextField(
            controller: _descriptionController,
            maxLines: null,
            expands: true,
            style: GoogleFontStyles.h5(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'There are many types of haircuts, from short to long, and from classic to modern styles. For example, a fade gradually shortens the hair from...',
              hintStyle: GoogleFontStyles.h6(color: Colors.white.withOpacity(0.5)),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _serviceNameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}