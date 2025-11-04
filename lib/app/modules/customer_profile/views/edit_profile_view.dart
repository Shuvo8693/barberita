import 'package:barberita/app/modules/customer_profile/controllers/customer_profile_controller.dart';
import 'package:barberita/app/modules/customer_profile/model/user_info_model.dart';
import 'package:barberita/common/app_images/network_image%20.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:barberita/common/custom_image_provider/custom_image_provider.dart';
import 'package:barberita/common/jwt_decoder/payload_value.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:barberita/common/widgets/custom_text_field.dart';
import 'package:get/get.dart';

// Edit Profile Screen
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final CustomerProfileController _profileController = Get.put(CustomerProfileController());
  String? _role;
  bool _isRoleLoaded = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  // Combine both async calls
  Future<void> _initializeData() async {
    await getRole();
    _profileController.fetchProfile();
  }

  Future<void> getRole() async {
    final result = await getPayloadValue();
    final role = result['userRole'];
    setState(() {
      _role = role;
      _isRoleLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Edit Profile',
      ),
      body: Obx(() {
        UserInfoModel userInfoModel = _profileController.userInfoModel.value;

        // Show loading while role or profile is loading
        if (!_isRoleLoaded || _profileController.isLoadingProfile.value) {
          return Center(child: CupertinoActivityIndicator());
        }

        if (userInfoModel.data == null) {
          return Center(child: Text('Reload the screen'));
        }

        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  // Profile Image
                  SizedBox(
                    height: _role == 'barber' ? 152.h : 100.h,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // cover image - visible only for barber
                        if (_role == 'barber')
                          CustomImageProvider.network(AppNetworkImage.saloon2mg).toImage(
                              height: 152.h,
                              width: double.infinity,
                              fit: BoxFit.cover),

                        // cover image update icon
                        if (_role == 'barber')
                          Positioned(
                            bottom: 10.h,
                            right: 16.w,
                            child: GestureDetector(
                              onTap: () async {
                                _profileController.coverImagePath ='';
                                String imagePath = await _profileController.pickImageFromGallery();
                                setState(() {
                                  _profileController.coverImagePath = imagePath;
                                });
                                if(_profileController.coverImagePath?.isNotEmpty==true ){
                                  Get.snackbar('Selected cover image ', _profileController.coverImagePath.toString() );
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2C2C2E),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                                child: Icon(Icons.camera_alt,
                                    color: Colors.white, size: 16.sp),
                              ),
                            ),
                          ),

                        // profile image
                        Positioned(
                          bottom: _role == 'barber' ? -40.h : 0.h,
                          left:_role == 'barber' ? 16.w : 130.w,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                  Border.all(color: Colors.white, width: 2.w),
                                ),
                                child: CircleAvatar(
                                  radius: 50.r,
                                  backgroundImage: NetworkImage(AppNetworkImage.saloonHairMen2Img),
                                  backgroundColor: Colors.grey[600],
                                ),
                              ),
                              // profile image update icon
                              Positioned(
                                bottom: 70.h,
                                right: 0,
                                child: InkWell(
                                  onTap: () async {
                                    _profileController.profileImagePath='';
                                    String imagePath = await _profileController.pickImageFromGallery();
                                    setState(() {
                                      _profileController.profileImagePath = imagePath;
                                    });
                                    if(_profileController.profileImagePath?.isNotEmpty==true ){
                                      Get.snackbar('Selected profile image ', _profileController.profileImagePath.toString() );
                                    }

                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(6.w),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF2C2C2E),
                                      shape: BoxShape.circle,
                                      border:
                                      Border.all(color: Colors.white, width: 2),
                                    ),
                                    child: Icon(Icons.camera_alt,
                                        color: Colors.white, size: 14.sp),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  Text(
                    userInfoModel.data?.name ?? '',
                    style: GoogleFontStyles.h4(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),

                  SizedBox(height: 4.h),

                  Text(
                    userInfoModel.data?.email ?? '',
                    style: GoogleFontStyles.h6(
                        color: Colors.white.withOpacity(0.7)),
                  ),
                  SizedBox(height: 32.h),

                  // Form Fields
                  _buildFormField('Full Name', _profileController.nameController!),
                  SizedBox(height: 16.h),
                  _buildFormField('Email', _profileController.emailController!),
                  SizedBox(height: 16.h),
                  _buildFormField(
                      'Mobile Number', _profileController.phoneController!),
                  SizedBox(height: 16.h),
                  _buildFormField('Address', _profileController.addressController!),

                  if (_role == 'barber')
                    Column(
                      children: [
                        SizedBox(height: 16.h),
                        _buildFormField(
                            'Experience', _profileController.experiencesController!),
                        SizedBox(height: 16.h),
                        _buildFormField(
                            'About your skill',
                            _profileController.aboutSkillsController!,
                            maxLine: 4),
                      ],
                    ),

                  SizedBox(height: 40.h),

                  // Save Update Button
                  Obx((){
                    return  CustomButton(
                      loading: _profileController.isLoadingUpdateUserInfo.value,
                      onTap: () async {
                        await _profileController.updateUserInfo(role: _role);
                      },
                      text: 'Save Update',
                      textStyle: GoogleFontStyles.h4(
                          color: Colors.white, fontWeight: FontWeight.w600),
                      color: const Color(0xFF55493E),
                      borderRadius: 12.r,
                      height: 56.h,
                    );
                   }

                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildFormField(String label, TextEditingController controller, {int? maxLine}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFontStyles.h6(color: Colors.white.withOpacity(0.7)),
        ),
        SizedBox(height: 8.h),
        CustomTextField(
          controller: controller,
          fillColor: const Color(0xFF2C2C2E),
          maxLines: maxLine ?? 1,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _profileController.nameController!.dispose();
    _profileController.emailController!.dispose();
    _profileController.genderController!.dispose();
    _profileController.phoneController!.dispose();
    _profileController.addressController!.dispose();
    super.dispose();
  }
}