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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),

              // Service Info Card
              // Container(
              //   padding: EdgeInsets.all(16.w),
              //   decoration: BoxDecoration(
              //     color: Colors.transparent,
              //     borderRadius: BorderRadius.circular(12.r),
              //     border: Border.all(
              //       color: Colors.white.withOpacity(0.3),
              //       width: 1,
              //     ),
              //   ),
              //   child: Row(
              //     children: [
              //       // Service Image
              //       Container(
              //         width: 50.w,
              //         height: 50.h,
              //         decoration: BoxDecoration(
              //           color: const Color(0xFF2C2C2E),
              //           borderRadius: BorderRadius.circular(8.r),
              //         ),
              //         child: widget.serviceImage != null
              //             ? ClipRRect(
              //           borderRadius: BorderRadius.circular(8.r),
              //           child: Image.asset(
              //             widget.serviceImage!,
              //             fit: BoxFit.cover,
              //           ),
              //         )
              //             : Icon(
              //           Icons.content_cut,
              //           color: Colors.white.withOpacity(0.7),
              //           size: 24.sp,
              //         ),
              //       ),
              //
              //       SizedBox(width: 16.w),
              //
              //       // Service Details
              //       Expanded(
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               widget.serviceName,
              //               style: GoogleFontStyles.h5(
              //                 color: Colors.white,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //             SizedBox(height: 4.h),
              //             Text(
              //               widget.serviceDescription,
              //               style: GoogleFontStyles.h6(
              //                 color: Colors.white.withOpacity(0.7),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              //
              // SizedBox(height: 40.h),

              // Feedback Section
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

                    SizedBox(height: 24.h),

                    // Feedback Text Field
                    CustomTextField(
                        controller: _feedbackController.commentCtrl,
                      maxLines: 5,
                      hintText: 'comments here ...',
                      fillColor: Colors.transparent,
                    )
                  ],
                ),
              ),

              const Spacer(),

              // Submit Button
              CustomButton(
                onTap: () {
                  if (_feedbackController.selectedRating > 0) {
                    _submitFeedback();
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
              ),

              SizedBox(height: 16.h),

              // Skip Button
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
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

              SizedBox(height: 20.h),
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
          'Thank You!',
          style: GoogleFontStyles.h4(color: Colors.white),
        ),
        content: Text(
          'Your feedback has been submitted successfully.\nRating: ${_feedbackController.selectedRating}/5',
          style: GoogleFontStyles.h5(color: Colors.white.withOpacity(0.8)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text(
              'OK',
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

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }
}