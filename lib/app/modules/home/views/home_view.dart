import 'package:barberita/common/app_images/network_image%20.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/widgets/casess_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barberita/common/app_color/app_colors.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:barberita/common/widgets/custom_text_field.dart';

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
                  // Filters
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 20.w),
                  //   child: Row(
                  //     children: [
                  //       _buildFilterButton('All', 0),
                  //       SizedBox(width: 12.w),
                  //       _buildFilterButton('Nearby Hairdresser', 1),
                  //     ],
                  //   ),
                  // ),
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
                    child: _buildFavouriteCard(),
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
                          Expanded(child: _buildTopRatedCard(0)),
                          SizedBox(width: 12.w),
                          Expanded(child: _buildTopRatedCard(1)),
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

  Widget _buildFavouriteCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          CustomNetworkImage(
            width: 80.w,
            height: 80.h,
            boxFit: BoxFit.cover,
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            imageUrl: AppNetworkImage.saloonHairMen2Img,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Marty\'s Hairdresser',
                        style: GoogleFontStyles.h5(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(Icons.favorite, color: Colors.red, size: 20.sp),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  'Braided',
                  style: GoogleFontStyles.h6(color: const Color(0xFFE6C4A3)),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text(
                      'Open now',
                      style: GoogleFontStyles.h6(color: Colors.green),
                    ),
                    SizedBox(width: 8.w),
                    Icon(Icons.star, color: Colors.amber, size: 14.sp),
                    SizedBox(width: 2.w),
                    Text(
                      '4.5',
                      style: GoogleFontStyles.h6(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Text(
                      'Price Range: \$2.99-\$100',
                      style: GoogleFontStyles.h6(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    const Spacer(),
                    CustomButton(
                      onTap: () {},
                      text: 'Book now',
                      height: 25.h,
                      width: 70.w,
                      textStyle: GoogleFontStyles.h6(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopRatedCard(int index) {
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

    return Container(
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
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
