import 'package:barberita/app/modules/hairdresser_details/controllers/hairdresser_details_controller.dart';
import 'package:barberita/app/modules/hairdresser_details/model/barber_details_model.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/widgets/see_more_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// About Tab Widget
class AboutTab extends StatefulWidget {
  const AboutTab({super.key});

  @override
  State<AboutTab> createState() => _AboutTabState();
}

class _AboutTabState extends State<AboutTab> {

  final HairdresserDetailsController _hairdresserDetailsController = Get.put(HairdresserDetailsController());

  @override
  void didChangeDependencies() async {
    await _hairdresserDetailsController.fetchBarberDetails();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      BarberDetails? barberDetails = _hairdresserDetailsController.barberDetailsModel.value.data;
      if(_hairdresserDetailsController.isLoadingBarberDetails.value){
        return Center(child: CupertinoActivityIndicator());
      }
      return SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hairdresser Name
            Text('Hairdresser: ${barberDetails?.name??''}',
              style: GoogleFontStyles.h4(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),

            // Working Hours
            Text(
              'Working Hour: ${barberDetails?.workingHour??''}',
              style: GoogleFontStyles.h5(
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            SizedBox(height: 16.h),

            // Experience
            Row(
              children: [
                Icon(
                  Icons.workspace_premium,
                  color: const Color(0xFFE6C4A3),
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Text('Experience ${barberDetails?.experience??''} years',
                  style: GoogleFontStyles.h5(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // Description
            SeeMoreText(
              text: barberDetails?.about??''
              ,style: GoogleFontStyles.h5(
              color: Colors.white.withOpacity(0.8),
              height: 1.5),
              characterLimit: 150,
            ),
            SizedBox(height: 16.h),
          ],
         ),
       );
      }
    );
  }
}
