import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/app_color/app_colors.dart';
import 'package:barberita/common/app_logo/app_logo.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/prefs_helper/prefs_helpers.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class RoleSelectionView extends StatefulWidget {
  const RoleSelectionView({super.key});

  @override
  State<RoleSelectionView> createState() => _RoleSelectionViewState();
}

class _RoleSelectionViewState extends State<RoleSelectionView> {
  String? _selectedRole = 'User';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 60.h),
              // Logo Placeholder
              AppLogo(height: 200.h,),

              SizedBox(height: 70.h),

              // Title
              Text(
                'Choose Your Role to Get Started',
                style: GoogleFontStyles.h3(
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 60.h),
              // Role Buttons
              _buildRoleButton(
                role: 'Customer',
                isSelected: _selectedRole == 'Customer',
              ),
              SizedBox(height: 16.h),
              _buildRoleButton(
                role: 'Barber',
                isSelected: _selectedRole == 'Barber',
              ),

              const Spacer(),

              CustomButton(
                  onTap: ()async{
                    if(_selectedRole !=null ){
                     await PrefsHelper.setString('role',_selectedRole?.toLowerCase());
                     final role = await PrefsHelper.getString('role');
                     print(role);
                     if(role=='barber'){
                        Get.toNamed(Routes.BARBARVERIFICATION);
                     }else{
                       Navigator.pushReplacementNamed(context, '/signup',arguments: {'role':_selectedRole});
                     }
                    }
                  },
                  text: 'Confirm'
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleButton({
    required String role,
    required bool isSelected,
  }) {

    return GestureDetector(
      onTap: () {
        setState((){
          _selectedRole = role;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 56.h,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.secondaryAppColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: isSelected
              ? null
              : Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            role,
            style: GoogleFontStyles.h4(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}