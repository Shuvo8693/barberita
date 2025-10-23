import 'package:barberita/app/data/api_constants.dart';
import 'package:barberita/app/modules/hairdresser_details/controllers/hairdresser_details_controller.dart';
import 'package:barberita/app/modules/hairdresser_details/model/barber_review_model.dart';
import 'package:barberita/common/app_images/network_image%20.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/widgets/casess_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


// Reviews Tab Widget
class ReviewsTab extends StatefulWidget {
  const ReviewsTab({super.key});

  @override
  State<ReviewsTab> createState() => _ReviewsTabState();
}

class _ReviewsTabState extends State<ReviewsTab> {
  final HairdresserDetailsController _hairdresserDetailsController = Get.put(HairdresserDetailsController());

  @override
  void didChangeDependencies() async {
    await _hairdresserDetailsController.fetchBarberReview();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Obx((){
      Review? review = _hairdresserDetailsController.barberReviewModel.value.data?.reviews?.first;
      if(_hairdresserDetailsController.isLoadingBarberReview.value){
        return Center(child: CupertinoActivityIndicator());
        } else if(review!.totalReviews! < 1 ){
           return Center(child: Text('No review available here'));
         }
          return SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Review Header
                Text(
                  'Review (${review.totalReviews})',
                  style: GoogleFontStyles.h4(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20.h),

                // Review Items
                ...List.generate(review.reviews!.length, (index){
                   final barberReviewIndex = review.reviews?[index];
                  return Padding(
                    padding:  EdgeInsets.only(bottom: 8.h),
                    child: _buildReviewItem(
                      barberReviewIndex?.name??'',
                      barberReviewIndex?.rating?.toStringAsFixed(1)??'',
                      '1 days ago',
                      barberReviewIndex?.comment??'',
                      '${ApiConstants.baseUrl}${barberReviewIndex?.image??''}',
                    ),
                  );
                }),

                SizedBox(height: 20.h),
              ],
            ),
          );
        }
      );
  }

  Widget _buildReviewItem(String name, String rating, String time, String review, String imageUrl) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info
          Row(
            children: [
              CustomNetworkImage(
                imageUrl: imageUrl,
                width: 40.w,
                height: 40.h,
                boxFit: BoxFit.cover,
                borderRadius: BorderRadius.all(Radius.circular(24.r)),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFontStyles.h5(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 14.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          rating,
                          style: GoogleFontStyles.h6(
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                time,
                style: GoogleFontStyles.h6(
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Review Text
          Text(
            review,
            style: GoogleFontStyles.h6(
              color: Colors.white.withOpacity(0.8),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

