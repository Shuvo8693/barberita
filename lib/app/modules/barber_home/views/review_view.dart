import 'package:barberita/app/data/api_constants.dart';
import 'package:barberita/app/modules/barber_home/controllers/barber_home_controller.dart';
import 'package:barberita/app/modules/barber_home/model/user_review_model.dart';
import 'package:barberita/app/modules/barber_home/widgets/review_card.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {

  final BarberHomeController _barberHomeController = Get.put(BarberHomeController());

  @override
  void didChangeDependencies()async {
    super.didChangeDependencies();
    await _barberHomeController.fetchUserReview();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Reviews',),
      body: SafeArea(
        child: Obx((){
          UserReviewData?  userReviewData =  _barberHomeController.userReviewModel.value.data;
          if(_barberHomeController.isLoadingUserReview.value){
            return Center(child: CupertinoActivityIndicator());
          }else if(userReviewData?.reviews?.isEmpty==true){
            return Center(child: Text('No review is found'));
          }
         final userReviewGroupData = userReviewData?.reviews?.first;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Review Count Header
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Text(
                  'Review (${userReviewGroupData?.totalReviews??0})',
                  style: GoogleFontStyles.h5(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // Reviews List
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: userReviewGroupData?.reviews?.length??0, // Sample count
                  itemBuilder: (context, index) {
                   final  userReviewGroupIndex = userReviewGroupData?.reviews?[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: ReviewCard(
                        reviewerName: userReviewGroupIndex?.name??'',
                        rating: userReviewGroupIndex?.rating?.toStringAsFixed(1)??'',
                        timeAgo: '4 days ago',
                        reviewText: userReviewGroupIndex?.comment??'',
                        avatarUrl: '${ApiConstants.baseUrl}${userReviewGroupIndex?.image??''}',
                      ),
                    );
                  },
                ),
              ),
            ],
           );
          }
        ),
      ),
    );
  }
}


