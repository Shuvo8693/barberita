import 'package:barberita/app/modules/customer_profile/controllers/settings_controller.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:barberita/common/widgets/html_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


// 5. Privacy Policy Screen
class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  final SettingsController _settingsController = Get.put(SettingsController());

  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();
    await _settingsController.termsPolicyApi(TermsAndPolicy.privacy);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Privacy Policy',),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Our Policy',
                style: GoogleFontStyles.h4(color: Colors.white, fontWeight: FontWeight.w600),
              ),

              SizedBox(height: 20.h),

              SafeArea(
                child: Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2C2C2E),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Obx((){
                    final content= _settingsController.termsAndPrivacyModel.value.data;
                    if(_settingsController.isLoadingTermsPrivacy.value){
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 24.w),
                      child: HTMLView(htmlData: content?.description??''),
                    );
                  },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}