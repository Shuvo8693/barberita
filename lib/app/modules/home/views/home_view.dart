import 'package:barberita/app/data/api_constants.dart';
import 'package:barberita/app/modules/home/controllers/home_controller.dart';
import 'package:barberita/app/modules/home/widgets/top_rated_card.dart';
import 'package:barberita/app/modules/notification/controllers/notification_controller.dart';
import 'package:barberita/app/modules/notification/model/unreadAndLatestNotification_model.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/app_images/network_image%20.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/bottom_menu/bottom_menu..dart';
import 'package:barberita/common/widgets/casess_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barberita/common/widgets/custom_text_field.dart';
import 'package:get/get.dart';

import '../widgets/favourite_hairdresser_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final homeController = Get.put(HomeController());
  final NotificationController _notificationController = Get.put(NotificationController());

  final TextEditingController _searchController = TextEditingController();
  int selectedFilterIndex = 0;
  List<String> recentSearch = [
    'The Blind Sa',
    'Marty\'s Hairdresser',
    'Fellow Hairdresser',
  ];

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await _notificationController.fetchBadgeCount();
    await homeController.fetchTopBarber();
    await homeController.fetchFavouriteBarber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(child: BottomMenu(0)),
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
                  Obx((){
                    UnreadLatestData? unreadLatestData = _notificationController.unreadAndLatestNotificationModel.value.data;
                    final badgeCount =unreadLatestData?.unreadCount??0;
                    return Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Profile Header
                          Row(
                            children: [
                              CustomNetworkImage(
                                imageUrl: "${ApiConstants.baseUrl}${unreadLatestData?.userInfo?.image??''}",
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
                                      unreadLatestData?.userInfo?.name??'',
                                      style: GoogleFontStyles.h5(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    // Text(
                                    //   '112/23 Park Street',
                                    //   style: GoogleFontStyles.h6(
                                    //     color: Colors.white.withOpacity(0.7),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.NOTIFICATION);
                                },
                                child:badgeCount < 1 ? Icon(
                                  Icons.notifications_outlined,
                                  color: Colors.white,
                                  size: 24.sp,
                                ): Badge.count(
                                  count: badgeCount ,
                                  child: Icon(
                                    Icons.notifications_outlined,
                                    color: Colors.white,
                                    size: 24.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                        ],
                      ),
                    );
                  }
                  ),
                  SizedBox(height: 20.h),
                  // Search Bar ===================
                  GestureDetector(
                    onTap: () {
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

                  // SizedBox(height: 20.h),

                  //=========== Recent Search Section =============
                  // Text(
                  //   'Recent Search Hairdresser',
                  //   style: GoogleFontStyles.h5(fontWeight: FontWeight.w600),
                  // ),
                  // SizedBox(height: 12.h),
                  // Recent Search Tags
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: recentSearch.map((value) {
                  //       return Padding(
                  //         padding: EdgeInsets.only(right: 8.w),
                  //         child: _buildSearchTag(value),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
                ],
              ),
            ),

            // ================= Content Section ===================
            Flexible(
              child: ListView(
                children: [
                  SizedBox(height: 20.h),
                  // Favourite Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.FAVOURITE);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Text(
                            'See All',
                            style: GoogleFontStyles.h5(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  // Favourite Card
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Obx(() {
                      final favouriteData = homeController.favouriteBarberModel.value.data ?? [];
                      if (homeController.isLoadingFavouriteBarber.value) {
                        return CupertinoActivityIndicator();
                      } else if (favouriteData.isEmpty) {
                        return Text('No available favourite');
                      }
                      final favouriteFirstData = favouriteData.first;
                      return FavouriteHairdresserCard(
                        imageUrl: favouriteFirstData?.barberId?.userId?.image ?? '',
                        name: favouriteFirstData?.barberId?.userId?.name ?? '',
                        type: 'Hair Style',
                        status: favouriteFirstData?.barberId?.isOpen == true ? 'Open now' : 'Closed now',
                        rating: favouriteFirstData?.barberId?.rating?.toStringAsFixed(1) ?? '',
                        price: '\$${favouriteFirstData?.barberId?.minPrice}-\$${favouriteFirstData?.barberId?.maxPrice}',
                        onTap: () {
                          // Handle booking action
                          if (favouriteFirstData?.barberId?.isOpen == false) {
                            Get.snackbar('Closed', 'Barber service is closed');
                          }
                          Get.toNamed(Routes.HAIRDRESSER_DETAILS,arguments: {'barberId':favouriteFirstData?.barberId?.id});
                        },
                      );
                    }),
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
                  Obx(() {
                    final barberTopRatedData = homeController.barberTopRatedModel.value.barberList ?? [];
                    if (homeController.isLoadingTopBarber.value) {
                      return CupertinoActivityIndicator();
                    } else if (barberTopRatedData.isEmpty) {
                      return Text('No available Barber');
                    }
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Row(
                          children: List.generate(barberTopRatedData.length, (index) {
                            final barberTopRatedIndex = barberTopRatedData[index];
                            return Padding(
                              padding: EdgeInsets.only(right: 8.w),
                              child: TopRatedCard(
                                index: index,
                                barberTopRated: barberTopRatedIndex,
                                onTap: () {
                                  Get.toNamed(Routes.HAIRDRESSER_DETAILS,arguments: {'barberId':barberTopRatedIndex.barberId});
                                },
                              ),
                            );
                          }),
                        ),
                      ),
                    );
                  }),
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
