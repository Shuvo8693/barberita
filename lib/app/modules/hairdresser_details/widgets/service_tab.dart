import 'package:barberita/common/app_images/network_image%20.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/widgets/casess_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Services Tab Widget
class ServicesTab extends StatefulWidget {
  const ServicesTab({super.key});

  @override
  State<ServicesTab> createState() => _ServicesTabState();
}

class _ServicesTabState extends State<ServicesTab> {
  List<Map<String, dynamic>> services = [
    {
      'title': 'Basic Hair cut',
      'description': 'A simple yet servicelook.',
      'price': '\$50',
      'image': AppNetworkImage.saloonHairMenImg,
    },
    {
      'title': 'Child Hair cut',
      'description': 'A simple yet servicelook.',
      'price': '\$50',
      'image': AppNetworkImage.saloonHairMen2Img,
    },
    {
      'title': 'Hair Trim',
      'description': 'A simple yet servicelook.',
      'price': '\$50',
      'image': AppNetworkImage.saloonHairMen3Img,
    },
    {
      'title': 'Basic Hair cut',
      'description': 'A simple yet servicelook.',
      'price': '\$50',
      'image': AppNetworkImage.saloonHairMen4Img,
    },
  ];
  List<bool>? isSelected ;

  @override
  void initState() {
    super.initState();
    isSelected = List<bool>.generate(services.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Services Header
          Text(
            'Our Services',
            style: GoogleFontStyles.h4(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20.h),
          ...List.generate(services.length, (index) {
            var service = services[index];  // Access the service based on the index
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    isSelected?[index] = !isSelected![index] ;
                  });
                  if(isSelected?[index]==true){
                    // need to make model of this list then add in the model
                  }
                },
                child: _buildServiceItem(
                  service['title'],
                  service['description'],
                  service['price'],
                  service['image'],
                  index
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildServiceItem(
    String title,
    String subtitle,
    String price,
    String image,
      int index

  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Row(
        children: [
          // Checkbox
          Icon(isSelected?[index]==true?Icons.check_box:Icons.check_box_outline_blank),
          SizedBox(width: 16.w),
          // Service Image
          CustomNetworkImage(
            imageUrl: image,
            width: 50.w,
            height: 50.h,
            boxFit: BoxFit.cover,
            borderRadius: BorderRadius.all(Radius.elliptical(12.r, 12.r)),
          ),
          SizedBox(width: 16.w),

          // Service Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFontStyles.h5(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: GoogleFontStyles.h6(
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),

          // Price
          Text(
            price,
            style: GoogleFontStyles.h5(
              color: const Color(0xFFE6C4A3),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
