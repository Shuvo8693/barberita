import 'package:barberita/app/modules/onboaring/widgets/onboarding_page.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barberita/common/app_color/app_colors.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _onboardingData = [
    OnboardingData(
      title: 'Appointment',
      description: 'Find the top Hairdresser near you in seconds, book an appointment, and enjoy a best grooming experience.',
      imagePath: 'assets/images/appointment.png', // Replace with your image path
      backgroundColor: const Color(0xFF2C2C3A),
    ),
    OnboardingData(
      title: 'Explore',
      description: 'With the app, you can easily schedule your grooming, ensuring a smooth and efficient experience. No more waiting in line - just book and relax!',
      imagePath: 'assets/images/explore.png', // Replace with your image path
      backgroundColor: const Color(0xFF2C2C3A),
    ),
    OnboardingData(
      title: 'Enjoy',
      description: 'Enjoy convenience, quality, and a stylish grooming experience without having to travel far! Grooming helps boost your confidence and overall appearance.',
      imagePath: 'assets/images/enjoy.png', // Replace with your image path
      backgroundColor: const Color(0xFF2C2C3A),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }else if(_currentPage == _onboardingData.length - 1 ){
       Get.toNamed(Routes.ROLESELECTION);
    } else {
      // Navigate to next screen (login/register)
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void _skipToEnd() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header with Skip button
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'onboarding',
                      style: GoogleFontStyles.h6(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    if (_currentPage < _onboardingData.length - 1)
                      GestureDetector(
                        onTap: _skipToEnd,
                        child: Text(
                          'Skip',
                          style: GoogleFontStyles.h5(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            // PageView Content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  return OnboardingPage( data: _onboardingData[index],);
                },
              ),
            ),

            // Page Indicators and Navigation
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              child: Column(
                children: [
                  // Page Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_onboardingData.length, (index) => _buildPageIndicator(index),
                    ),
                  ),

                  SizedBox(height: 40.h),

                  // Navigation Button
                  GestureDetector(
                    onTap: _nextPage,
                    child: Container(
                      width: double.infinity,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(28.r),
                      ),
                      child: Center(
                        child: Text(
                          _currentPage == _onboardingData.length - 1
                              ? 'Get Started'
                              : 'Next',
                          style: GoogleFontStyles.h4(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildPageIndicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      height: 8.h,
      width: _currentPage == index ? 24.w : 8.w,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? AppColors.primaryColor
            : Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }

}

class OnboardingData {
  final String title;
  final String description;
  final String imagePath;
  final Color backgroundColor;

  OnboardingData({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.backgroundColor,
  });
}