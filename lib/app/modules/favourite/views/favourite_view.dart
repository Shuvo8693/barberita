import 'package:barberita/app/modules/home/controllers/home_controller.dart';
import 'package:barberita/app/modules/home/widgets/favourite_hairdresser_card.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/app_images/network_image%20.dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class FavouriteView extends StatefulWidget {
  const FavouriteView({super.key});

  @override
  State<FavouriteView> createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {
  final HomeController _homeController = Get.put(HomeController());

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await _homeController.fetchFavouriteBarber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Favourite'),
      body: Obx(() {
        final favouriteData = _homeController.favouriteBarberModel.value.data ?? [];
        if (_homeController.isLoadingFavouriteBarber.value) {
          return Center(child: CupertinoActivityIndicator());
        } else if (favouriteData.isEmpty) {
          return Text('No available favourite');
        }
        return ListView.builder(
          itemCount: favouriteData.length,
          itemBuilder: (context, index) {
             final favoriteDataIndex = favouriteData[index];
            return Padding(
              padding: EdgeInsets.all(8.sp),
              child: FavouriteHairdresserCard(
            imageUrl: favoriteDataIndex?.barberId?.userId?.image ?? '',
              name: favoriteDataIndex?.barberId?.userId?.name ?? '',
              type: 'Hair Style',
              status: favoriteDataIndex?.barberId?.isOpen == true ? 'Open now' : 'Closed now',
              rating: favoriteDataIndex?.barberId?.rating?.toStringAsFixed(1) ?? '',
              price: '\$${favoriteDataIndex?.barberId?.minPrice}-\$${favoriteDataIndex?.barberId?.maxPrice}',
              onTap: () {
                // Handle booking action
                if (favoriteDataIndex?.barberId?.isOpen == false) {
                  Get.snackbar('Closed', 'Barber service is closed');
                }
                Get.toNamed(Routes.HAIRDRESSER_DETAILS,arguments: {'barberId':favoriteDataIndex?.barberId?.id});
              },
             )
            );
          },
        );
      }),
    );
  }
}
