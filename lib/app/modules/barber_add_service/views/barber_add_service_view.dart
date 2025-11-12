
import 'package:barberita/app/modules/barber_add_service/controllers/barber_add_service_controller.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/bottom_menu/bottom_menu..dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:barberita/common/widgets/custom_text_field.dart';

// Add Service Screen
class BarberAddServiceView extends StatefulWidget {
  const BarberAddServiceView({super.key});

  @override
  State<BarberAddServiceView> createState() => _BarberAddServiceViewState();
}

class _BarberAddServiceViewState extends State<BarberAddServiceView> {
final BarberAddServiceController _addServiceController = Get.put(BarberAddServiceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(child:  BottomMenu(1)),
      appBar: CustomAppBar(title: 'Add Service'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Single Image Picker Container
              _buildImagePickerContainer(),

              SizedBox(height: 32.h),

              // Service Name Field
              _buildFormField('Service Name', _addServiceController.serviceNameController, 'e.g. Hair cut'),

              SizedBox(height: 20.h),

              // Price Field
              _buildFormField('Price', _addServiceController.priceController, 'e.g. \$100'),

              SizedBox(height: 20.h),

              // Description Field
              Text('Description', style: GoogleFontStyles.h6(color: Colors.white.withOpacity(0.7))),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: _addServiceController.descriptionController,
                maxLines: 4,
                fillColor:  const Color(0xFF2C2C2E),
                hintText: 'Type here ...',
              ),

              SizedBox(height: 40.h),

              // Save Button
              Obx(() {
                return CustomButton(
                  loading: _addServiceController.isLoadingAddService.value,
                  onTap: () async {
                    await _addServiceController.addBarberServices();
                  },
                  text: 'Save',
                  textStyle: GoogleFontStyles.h4(
                      color: Colors.white, fontWeight: FontWeight.w600),
                );
               }
              ),
            ],
          ),
        ),
      ),
    );
  }
 /// === todo: Need to placement this method and also refactored
  Widget _buildImagePickerContainer() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: double.infinity,
        height: 180.h,
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2E),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: _addServiceController.serviceImagePath != null
            ? Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.file(
                File(_addServiceController.serviceImagePath!),
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildEmptyContainer();
                },
              ),
            ),
            Positioned(
              top: 12.h,
              right: 12.w,
              child: GestureDetector(
                onTap: _removeImage,
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close, color: Colors.white, size: 20.sp),
                ),
              ),
            ),
          ],
        )
            : _buildEmptyContainer(),
      ),
    );
  }

  Widget _buildEmptyContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.add_photo_alternate_outlined,
            color: Colors.white.withOpacity(0.7),
            size: 48.sp,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'Add Service Photo',
          style: GoogleFontStyles.h5(
            color: Colors.white.withOpacity(0.7),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Tap to select from camera or gallery',
          style: GoogleFontStyles.h6(
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      ],
    );
  }

  void _pickImage() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2C2C2E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Image Source',
                style: GoogleFontStyles.h4(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.h),

              ListTile(
                leading: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF55493E),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(Icons.camera_alt, color: Colors.white, size: 24.sp),
                ),
                title: Text('Camera', style: GoogleFontStyles.h5(color: Colors.white)),
                subtitle: Text('Take a new photo', style: GoogleFontStyles.h6(color: Colors.white.withOpacity(0.7))),
                onTap: () {
                  Navigator.pop(context);
                  _selectMedia(imageSource: ImageSource.camera);
                },
              ),

              ListTile(
                leading: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF55493E),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(Icons.photo_library, color: Colors.white, size: 24.sp),
                ),
                title: Text('Gallery', style: GoogleFontStyles.h5(color: Colors.white)),
                subtitle: Text('Choose from gallery', style: GoogleFontStyles.h6(color: Colors.white.withOpacity(0.7))),
                onTap: () {
                  Navigator.pop(context);
                  _selectMedia(imageSource: ImageSource.gallery);
                },
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectMedia({ImageSource? imageSource}) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: imageSource!,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _addServiceController.serviceImagePath = image.path;
        });
      }
    } catch (e) {
      _showErrorSnackBar('Error accessing camera');
    }
  }


  void _removeImage() {
    setState(() {
      _addServiceController.serviceImagePath = null;
    });
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }
  /// todo: =========== till here =============

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

}