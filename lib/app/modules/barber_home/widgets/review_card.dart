import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewCard extends StatelessWidget {
  final String reviewerName;
  final String rating;
  final String timeAgo;
  final String reviewText;
  final String avatarUrl;

  const ReviewCard({
    super.key,
    required this.reviewerName,
    required this.rating,
    required this.timeAgo,
    required this.reviewText,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reviewer Info Row
          Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 20.r,
                backgroundImage: AssetImage(avatarUrl),
                backgroundColor: Colors.grey[600],
                onBackgroundImageError: (exception, stackTrace) {},
                child: Image.asset(
                  avatarUrl,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 20.sp,
                    );
                  },
                ),
              ),

              SizedBox(width: 12.w),

              // Name and Rating
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reviewerName,
                      style: GoogleFontStyles.h5(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          rating,
                          style: GoogleFontStyles.h6(
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Time Ago
              Text(
                timeAgo,
                style: GoogleFontStyles.h6(
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Review Text
          Text(
            reviewText,
            style: GoogleFontStyles.h6(
              color: Colors.white.withOpacity(0.8),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}