import 'package:barberita/app/modules/hairdresser_details/controllers/hairdresser_details_controller.dart';
import 'package:barberita/app/modules/hairdresser_details/widgets/about_tab.dart';
import 'package:barberita/app/modules/hairdresser_details/widgets/review_tab.dart';
import 'package:barberita/app/modules/hairdresser_details/widgets/service_tab.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/app_images/network_image%20.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/widgets/casess_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barberita/common/app_color/app_colors.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:get/get.dart';

class HairdresserDetailsView extends StatefulWidget {
  const HairdresserDetailsView({super.key});

  @override
  State<HairdresserDetailsView> createState() => _HairdresserDetailsViewState();
}

class _HairdresserDetailsViewState extends State<HairdresserDetailsView> with SingleTickerProviderStateMixin {
  final HairdresserDetailsController _hairdresserDetailsController = Get.put(HairdresserDetailsController());

  late TabController _tabController;
  bool isFavorite = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await _hairdresserDetailsController.fetchBarberDetails();
  }



  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Hero Image Section
            Stack(
              children: [
                Obx((){
                String? image = _hairdresserDetailsController.barberDetailsModel.value.data?.image;
                  return CustomNetworkImage(imageUrl: image??'', height: 200.h,boxFit: BoxFit.cover,);
                }),
                // Back Button
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 18.sp,
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: Colors.red,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Rating Badge
                Positioned(
                  bottom: 16.h,
                  right: 16.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '4.5',
                          style: GoogleFontStyles.h6(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Tab Bar
            Container(
              color: AppColors.darkJungleGreenBGColor,
              child: TabBar(
                controller: _tabController,
                indicatorColor: AppColors.secondaryAppColor,
                indicatorWeight: 2,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white.withOpacity(0.6),
                labelStyle: GoogleFontStyles.h5(fontWeight: FontWeight.w600),
                unselectedLabelStyle: GoogleFontStyles.h5(fontWeight: FontWeight.w400),
                tabs: const [
                  Tab(text: 'About'),
                  Tab(text: 'Reviews'),
                  Tab(text: 'Services'),
                ],
              ),
            ),

            // Tab Bar View Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  AboutTab(),
                  ReviewsTab(),
                  ServicesTab(),
                ],
              ),
            ),

            // Book Appointment Button
            Padding(
              padding: EdgeInsets.all(20.w),
              child: CustomButton(
                onTap: () {
                  // Handle booking
                  Get.toNamed(Routes.BOOK_APPOINTMENT);
                },
                text: 'Book Appointment',
              ),
            ),
          ],
        ),
      ),
    );
  }


}