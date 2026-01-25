import 'package:barberita/app/modules/booking/controllers/feedback_controller.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class FeedbackView extends StatefulWidget {


  const FeedbackView({super.key,});

  @override
  State<FeedbackView> createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView> {
 final FeedbackController _feedbackController = Get.put(FeedbackController());
 bool isUpdateReview = false;
  @override
  void initState() {
    super.initState();
    getFeedbackArguments();
  }
getFeedbackArguments(){
 bool isReviewUpdate = Get.arguments['isUpdateReview']??false;
 isUpdateReview = isReviewUpdate;
 setState(() {});
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(24.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2C2C2E),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Column(
                          children: [
                            // Title
                            Text(
                              'Tell us your feedback',
                              style: GoogleFontStyles.h4(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 20.h),
                            // Star Rating
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(5, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _feedbackController.selectedRating = index + 1;
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                                    child: Icon(
                                      Icons.star,
                                      size: 40.sp,
                                      color: index < _feedbackController.selectedRating
                                          ? Colors.amber
                                          : Colors.white.withOpacity(0.3),
                                    ),
                                  ),
                                );
                              }),
                            ),
                            SizedBox(height: 20.h),
                            // Description
                            Text(
                              'Let us know how you feel about the Barber\'s\nHair cut and service',
                              textAlign: TextAlign.center,
                              style: GoogleFontStyles.h6(
                                color: Colors.white.withOpacity(0.7),
                                height: 1.4,
                              ),
                            ),

                            SizedBox(height: 20.h),

                            // Feedback Text Field
                            CustomTextField(controller: _feedbackController.commentCtrl,
                              maxLines: 5,
                              hintText: 'comments here ...',
                              fillColor: Colors.transparent,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),


              // Submit Button
              Obx((){
                 return CustomButton(
                   loading:isUpdateReview?_feedbackController.isLoadingUpdateReview.value: _feedbackController.isLoadingPostReview.value,
                   onTap: () async {
                     if (_feedbackController.selectedRating > 0) {
                       if(isUpdateReview){
                         await _feedbackController.updateReview(callBack: (){
                           _submitFeedback();
                           setState(() {
                             _feedbackController.selectedRating = 0;
                             _feedbackController.commentCtrl.clear();
                           });
                         });
                       }else{
                         await _feedbackController.postReview(callBack: (){
                           _submitFeedback();
                           setState(() {
                             _feedbackController.selectedRating = 0;
                             _feedbackController.commentCtrl.clear();
                           });
                         });
                       }
                     } else {
                       ScaffoldMessenger.of(context).showSnackBar(
                         const SnackBar(
                           content: Text('Please select a rating'),
                           backgroundColor: Colors.red,
                         ),
                       );
                     }
                   },
                   text: 'Submit',
                 );
                }

              ),

              SizedBox(height: 16.h),

              // Skip Button
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _feedbackController.selectedRating = 0;
                      _feedbackController.commentCtrl.clear();
                    });
                  },
                  child: Text(
                    'Skip',
                    style: GoogleFontStyles.h5(
                      color: Colors.white.withOpacity(0.7),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 6.h),
            ],
          ),
        ),
      ),
    );
  }

  void _submitFeedback() {
    // Handle feedback submission
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2E),
        title: Text(
          'Thank You!', style: GoogleFontStyles.h4(color: Colors.white)),
        content: Text(
          'Your feedback has been submitted successfully.',
          style: GoogleFontStyles.h5(color: Colors.white.withOpacity(0.8)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK',
              style: GoogleFontStyles.h5(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}