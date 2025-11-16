import 'dart:async';

import 'package:barberita/app/modules/home/widgets/favourite_hairdresser_card.dart';
import 'package:barberita/app/modules/search_hairdresser/controllers/search_hairdresser_controller.dart';
import 'package:barberita/app/modules/search_hairdresser/model/nearby_barber_model.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/app_images/network_image%20.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barberita/common/app_color/app_colors.dart';
import 'package:barberita/common/widgets/custom_text_field.dart';
import 'package:get/get.dart';

class SearchHairdresserView extends StatefulWidget {
  const SearchHairdresserView({super.key});

  @override
  State<SearchHairdresserView> createState() => _SearchHairdresserViewState();
}

class _SearchHairdresserViewState extends State<SearchHairdresserView> {
  final TextEditingController _searchController = TextEditingController();
  final SearchHairdresserController _searchHairdresserController = Get.put(SearchHairdresserController());
  int selectedFilterIndex = 0;

  Timer? _debouncer;

  onSearchChanged(String? query) {
    if (_debouncer?.isActive ?? false) _debouncer?.cancel();  // when timer counting then it will be active

    _debouncer = Timer(const Duration(milliseconds: 500), () async {   // when type should be stoped for 400 milliseconds  then it will hit the inner function
      if (selectedFilterIndex == 0) {
        await _searchHairdresserController.fetchBarber(name: query, isNearby: false);
      } else if (selectedFilterIndex == 1) {
        await _searchHairdresserController.fetchBarber(name: query, isNearby: true);
      }
    });
  }

  fetchBarber(){
    if (selectedFilterIndex == 0) {
      _searchHairdresserController.fetchBarber(name: '', isNearby: false);
    } else if (selectedFilterIndex == 1) {
      _searchHairdresserController.fetchBarber(name: '', isNearby: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchBarber();
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
                  onChanged: onSearchChanged,
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
          Obx((){
            List<NearbyBarber>? nearbyBarberList = _searchHairdresserController.nearByBarberModel.value.nearbyBarberList??[];
            if(_searchHairdresserController.isLoadingNearByBarber.value){
              return Center(child: CupertinoActivityIndicator());
            }else if(nearbyBarberList.isEmpty){
              return Center(child: Text('No Nearby barber is available'));
            }
            return Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: nearbyBarberList.length, // Placeholder count
                itemBuilder: (context, index) {
                  final nearbyBarberIndex = nearbyBarberList[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child:  FavouriteHairdresserCard(
                      imageUrl: nearbyBarberIndex.image??'',
                      name: nearbyBarberIndex.name??'',
                      type: 'Hair Style',
                      status: nearbyBarberIndex.barberDetails?.isOpen==true ? 'Open now' : 'Closed now',
                      rating: nearbyBarberIndex.barberDetails?.rating?.toStringAsFixed(1) ?? '',
                      price: '\$${nearbyBarberIndex.minPrice} - \$${nearbyBarberIndex.maxPrice}',
                      onTap: () {
                        // Handle booking action
                        if (nearbyBarberIndex.barberDetails?.isOpen == false) {
                          Get.snackbar('Closed', 'Barber service is closed');
                        }
                        Get.toNamed(Routes.HAIRDRESSER_DETAILS,arguments: {'barberId':nearbyBarberIndex.barberDetails?.id});
                      },
                    ),
                  );
                },
              ),
            );
           }
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
