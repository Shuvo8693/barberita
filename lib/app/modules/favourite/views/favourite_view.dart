import 'package:barberita/app/modules/home/widgets/favourite_hairdresser_card.dart';
import 'package:barberita/common/app_images/network_image%20.dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class FavouriteView extends StatelessWidget {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Favourite',),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(8.sp),
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
            ),
          );
        },
      ),
    );
  }
}
