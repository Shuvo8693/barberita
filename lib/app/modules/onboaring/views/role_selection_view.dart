import 'package:barberita/common/app_color/app_colors.dart';
import 'package:barberita/common/app_logo/app_logo.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


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
      backgroundColor: const Color(0xFF2C2C3A),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 60.h),
              // Logo Placeholder
              AppLogo(height: 200.h,),

              SizedBox(height: 80.h),

              // Title
              Text(
                'Choose Your Role to Get Started',
                style: GoogleFontStyles.h3(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 60.h),

              // Role Buttons
              _buildRoleButton(
                role: 'User',
                isSelected: _selectedRole == 'User',
              ),

              SizedBox(height: 16.h),

              _buildRoleButton(
                role: 'Barber',
                isSelected: _selectedRole == 'Barber',
              ),

              const Spacer(),

              CustomButton(
                  onTap: (){
                    if (_selectedRole == 'User') {
                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      Navigator.pushReplacementNamed(context, '/home');
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
        setState(() {
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