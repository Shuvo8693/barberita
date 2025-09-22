import 'package:barberita/app/modules/home/widgets/top_rated_card.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/app_images/network_image%20.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/widgets/casess_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barberita/common/widgets/custom_text_field.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../widgets/favourite_hairdresser_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();
  int selectedFilterIndex = 0;
  List<String> recentSearch = [
    'The Blind Sa',
    'Marty\'s Hairdresser',
    'Fellow Hairdresser',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //  ============== Header Section ====================
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Header
                  Row(
                    children: [
                      CustomNetworkImage(
                        imageUrl: AppNetworkImage.saloonHairMenImg,
                        boxShape: BoxShape.circle,
                        height: 38.h,
                        width: 38.w,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Albert Flores',
                              style: GoogleFontStyles.h5(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '112/23 Park Street',
                              style: GoogleFontStyles.h6(
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          Icon(
                            Icons.notifications_outlined,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 8.w,
                              height: 8.h,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  // Search Bar ===================
                  GestureDetector(
                    onTap: (){
                      //==== Nav to search screen ===
                      Get.toNamed(Routes.SEARCH_HAIRDRESSER);
                    },
                    child: AbsorbPointer(
                      child: CustomTextField(
                        controller: _searchController,
                        hintText: 'Search',
                        hintStyle: GoogleFontStyles.h5(
                          color: Colors.white.withOpacity(0.5),
                        ),
                        fillColor: const Color(0xFF2C2C2E),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white.withOpacity(0.5),
                          size: 20.sp,
                        ),
                        suffixIcon: Icon(
                          Icons.tune,
                          color: Colors.white.withOpacity(0.5),
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Recent Search Section
                  Text(
                    'Recent Search Hairdresser',
                    style: GoogleFontStyles.h5(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 12.h),
                  // Recent Search Tags
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: recentSearch.map((value) {
                        return Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: _buildSearchTag(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // ================= Content Section ===================
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: 20.h),

                  // Favourite Section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Text(
                      'Favourite',
                      style: GoogleFontStyles.h5(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Favourite Card
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: FavouriteHairdresserCard(
                      imageUrl: AppNetworkImage.saloonHairMen2Img,
                      name: 'Marty\'s Hairdresser',
                      type: 'Braided',
                      status: 'Open now',
                      rating: '4.5',
                      price: '\$2.99-\$100',
                      onTap: () {
                        // Handle booking action
                      },
                    )
                    ,
                  ),

                  SizedBox(height: 20.h),

                  // Top Rated Section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Text(
                      'Top Rated Hairdresser',
                      style: GoogleFontStyles.h5(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Top Rated Grid
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Row(
                        children: [
                          Expanded(child: TopRatedCard(index: 0)),
                          SizedBox(width: 12.w),
                          Expanded(child: TopRatedCard(index:1)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Text(
        text,
        style: GoogleFontStyles.h6(color: Colors.white.withOpacity(0.8)),
      ),
    );
  }

  Widget _buildFilterButton(String text, int index) {
    bool isSelected = selectedFilterIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilterIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE6C4A3) : const Color(0xFF2C2C2E),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          text,
          style: GoogleFontStyles.h6(
            color: isSelected ? Colors.black : Colors.white.withOpacity(0.8),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }




  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
