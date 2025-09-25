import 'package:barberita/app/modules/barber_home/widgets/review_card.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Reviews',),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Review Count Header
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Text(
                'Review (1208)',
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
                itemCount: 5, // Sample count
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: ReviewCard(
                      reviewerName: 'John Perkins',
                      rating: '4.5',
                      timeAgo: '4 days ago',
                      reviewText: 'The barbers are highly skilled, offering everything from sharp, contemporary cuts to classic styles. The atmosphere is welcoming, with a nostalgic old-school vibe that makes it feel like you\'ve stepped into a time capsule of barbering excellence.....',
                      avatarUrl: 'assets/images/reviewer${index + 1}.jpg',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


