import 'package:barberita/app/data/api_constants.dart';
import 'package:barberita/app/modules/barber_home/views/review_view.dart';
import 'package:barberita/app/modules/customer_profile/controllers/customer_profile_controller.dart';
import 'package:barberita/app/modules/customer_profile/controllers/settings_controller.dart';
import 'package:barberita/app/modules/customer_profile/model/user_info_model.dart';
import 'package:barberita/app/modules/customer_profile/views/settings/settings_screen.dart';
import 'package:barberita/app/modules/customer_profile/views/support_view.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/app_images/network_image%20.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/bottom_menu/bottom_menu..dart';
import 'package:barberita/common/jwt_decoder/payload_value.dart';
import 'package:barberita/common/prefs_helper/prefs_helpers.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:barberita/common/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'edit_profile_view.dart';

// Profile Screen (Main)
class CustomerProfileView extends StatefulWidget {
  const CustomerProfileView({super.key});

  @override
  State<CustomerProfileView> createState() => _CustomerProfileViewState();
}

class _CustomerProfileViewState extends State<CustomerProfileView> {
  final CustomerProfileController _profileController = Get.put(CustomerProfileController());
  final SettingsController _settingsController = Get.put(SettingsController());
  String? _role;
  String? _myId;
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
    final myid = result['userId'];
    setState(() {
      _role = role;
      _myId = myid;
      _isRoleLoaded = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(child: BottomMenu(2)),
      body: SafeArea(
        child: Column(
          children: [
            // Profile Header
            Obx((){
              UserInfoModel userInfoModel = _profileController.userInfoModel.value;

              // Show loading while role or profile is loading
              if (!_isRoleLoaded || _profileController.isLoadingProfile.value) {
                return Center(child: CupertinoActivityIndicator());
              }

              if (userInfoModel.data == null) {
                return Center(child: Text('Reload the screen'));
              }

              return Container(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),

                    // Profile Image
                    CircleAvatar(
                      radius: 60.r,
                      backgroundImage: NetworkImage('${ApiConstants.baseUrl}${userInfoModel.data?.image??''}'),
                      backgroundColor: Colors.grey[600],
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: 120.w,
                      child: Text(userInfoModel.data?.name ?? '',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: GoogleFontStyles.h4(
                            color: Colors.white, fontWeight: FontWeight.w600),),
                    ),

                    SizedBox(height: 4.h),

                    Text(
                      userInfoModel.data?.email ?? '',
                      style: GoogleFontStyles.h6(
                          color: Colors.white.withOpacity(0.7)),
                    ),
                  ],
                ),
              );
            }

            ),

            // Menu Options
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      _buildMenuItem(
                        icon: Icons.person_outline,
                        title: 'Edit Profile',
                        onTap: () {
                         Get.toNamed(Routes.EDITPROFILE);
                        },
                      ),

                      SizedBox(height: 16.h),

                      _buildMenuItem(
                        icon: Icons.settings_outlined,
                        title: 'Settings',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingsScreen(),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 16.h),

                      _buildMenuItem(
                        icon: Icons.support_agent_outlined,
                        title: 'Support',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SupportScreen(),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 16.h),

                      _buildMenuItem(
                        icon: Icons.reviews,
                        title: 'Review',
                        onTap: () {
                          Get.toNamed(Routes.REVIEW,arguments: {'userId': _myId});
                        },
                      ),
                      SizedBox(height: 16.h),
                      Obx((){
                        UserInfoData userInfoData = _profileController.userInfoModel.value.data?? UserInfoData();

                        return _buildMenuItem(
                          icon: Icons.switch_right,
                          title: _settingsController.isLoadingServiceActivation.value? 'Status Updating ....':'Active Status',
                          value: userInfoData.isOpen??false,
                          isActiveSwitch: true,
                          onChanged: (value) async{
                           await _settingsController.serviceActivation(voidCallBack: (){
                             if (_profileController.userInfoModel.value.data != null) {
                               _profileController.userInfoModel.value.data?.isOpen = value;
                               _profileController.userInfoModel.refresh();
                             }
                            });
                          },
                          onTap: () {},
                        );
                      }

                      ),

                      verticalSpacing(40.h),

                      // Log Out Button
                      GestureDetector(
                        onTap: () => _showLogoutDialog(context),
                        child: Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: Colors.red.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout,
                                color: Colors.red,
                                size: 24.sp,
                              ),
                              SizedBox(width: 16.w),
                              Text(
                                'Log Out',
                                style: GoogleFontStyles.h5(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.red,
                                size: 16.sp,
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 50.h), // Space for bottom nav
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isActiveSwitch = false,
    bool value = true,
    Function(bool value)? onChanged,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2E),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24.sp),
            SizedBox(width: 16.w),
            Text(
              title,
              style: GoogleFontStyles.h5(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            isActiveSwitch
                ? Switch(
                    value: value,
                    onChanged: onChanged,
                    padding: EdgeInsets.all(0),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: Colors.green,
                  )
                : Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white.withOpacity(0.5),
                    size: 16.sp,
                  ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2E),
        title: Text(
          'Log out Account',
          style: GoogleFontStyles.h4(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Do you want to log out your profile?',
          style: GoogleFontStyles.h5(color: Colors.white.withOpacity(0.8)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFontStyles.h5(color: Colors.white.withOpacity(0.7)),
            ),
          ),
          Obx((){
            return  CustomButton(
              loading: _profileController.isLoadingLogOut.value,
              width: 80.w,
              height: 35.h,
              onTap: () async {
                await _profileController.logout();
              },
              text: 'Log out',
              color: Colors.red,
            );
           }

          ),
        ],
      ),
    );
  }
}
