import 'package:barberita/app/modules/splash/controllers/splash_controller.dart';
import 'package:barberita/common/app_color/app_colors.dart';
import 'package:barberita/common/app_logo/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final splashController = Get.put(SplashController());

  // @override
  // void initState() {
  //   super.initState();
  //   splashController.navigateTo();
  // }

  @override
  void didChangeDependencies() {
    splashController.navigateTo();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.almondColor,
      body:  Center(
        child: AppLogo(height: 300.h,),
      ),
    );
  }
}
