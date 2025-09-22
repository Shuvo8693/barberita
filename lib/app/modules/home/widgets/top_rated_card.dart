import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/app_color/app_colors.dart';
import 'package:barberita/common/app_images/network_image%20.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/widgets/casess_network_image.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TopRatedCard extends StatelessWidget {
  final int index;

  const TopRatedCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    // List of hairdressers data
    List<Map<String, dynamic>> hairdressers = [
      {
        'name': 'Marty\'s Hairdresser',
        'image': AppNetworkImage.saloonHairMen3Img,
        'rating': '4.5',
        'type': 'Braided',
        'status': 'Open Now',
        'price': '\$2.99-\$100',
      },
      {
        'name': 'Marty\'s Hairdresser',
        'image': AppNetworkImage.saloonHairMen4Img,
        'rating': '4.5',
        'type': 'Flathead',
        'status': 'Open Now',
        'price': '\$2.99-\$100',
      },
    ];

    var data = hairdressers[index];

    return GestureDetector(
      onTap: (){
        Get.toNamed(Routes.HAIRDRESSER_DETAILS);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CustomNetworkImage(
                  imageUrl: data['image'],
                  height: 120.h,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  ),
                ),
                Positioned(
                  top: 8.h,
                  left: 8.w,
                  child: Icon(Icons.favorite, color: Colors.red, size: 20.sp),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          data['name'],
                          style: GoogleFontStyles.h6(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(Icons.star, color: Colors.amber, size: 14.sp),
                      SizedBox(width: 2.w),
                      Text(
                        data['rating'],
                        style: GoogleFontStyles.customSize(
                          size: 10.sp,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    data['type'],
                    style: GoogleFontStyles.customSize(
                      size: 10.sp,
                      color: const Color(0xFFE6C4A3),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    data['status'],
                    style: GoogleFontStyles.customSize(
                      size: 10.sp,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Price Range: ${data['price']}',
                    style: GoogleFontStyles.customSize(
                      size: 9.sp,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomButton(onTap: () {}, text: 'Book now', height: 30.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
