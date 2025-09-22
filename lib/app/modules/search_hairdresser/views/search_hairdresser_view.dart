import 'package:barberita/app/modules/home/widgets/favourite_hairdresser_card.dart';
import 'package:barberita/common/app_images/network_image%20.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barberita/common/app_color/app_colors.dart';
import 'package:barberita/common/widgets/custom_text_field.dart';

class SearchHairdresserView extends StatefulWidget {
  const SearchHairdresserView({super.key});

  @override
  State<SearchHairdresserView> createState() => _SearchHairdresserViewState();
}

class _SearchHairdresserViewState extends State<SearchHairdresserView> {
  final TextEditingController _searchController = TextEditingController();
  int selectedFilterIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:AppColors.darkJungleGreenBGColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20.sp,
          ),
        ),
        title: Text(
          'Search Hairdresser',
          style: GoogleFontStyles.h4(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Section
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                // Search Bar
                CustomTextField(
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

                SizedBox(height: 20.h),

                // Filter Buttons
                Row(
                  children: [
                    _buildFilterButton('All', 0),
                    SizedBox(width: 12.w),
                    _buildFilterButton('Nearby Hairdresser', 1),
                  ],
                ),
              ],
            ),
          ),

          // Results List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: 4, // Placeholder count
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child:  FavouriteHairdresserCard(
                    imageUrl: AppNetworkImage.saloonHairMen2Img,
                    name: 'Marty\'s Hairdresser',
                    type: 'Braided',
                    status: 'Open now',
                    rating: '4.5',
                    price: '\$2.99-\$100',
                    onTap: () {
                      // Handle booking action
                    },
                  ),
                );
              },
            ),
          ),
        ],
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
