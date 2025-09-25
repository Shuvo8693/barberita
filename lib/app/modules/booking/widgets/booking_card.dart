import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingCard extends StatelessWidget {
  final String name;
  final String service;
  final String rating;
  final String price;
  final String time;
  final String date;
  final String status;
  final String imageUrl;
  final String role;
  final VoidCallback onDetailsTap;

  const BookingCard({
    super.key,
    required this.name,
    required this.service,
    required this.rating,
    required this.price,
    required this.time,
    required this.date,
    required this.status,
    required this.imageUrl,
    required this.onDetailsTap,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          // Profile Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset(
              imageUrl,
              width: 60.w,
              height: 60.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 60.w,
                  height: 60.h,
                  color: Colors.grey[600],
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30.sp,
                  ),
                );
              },
            ),
          ),

          SizedBox(width: 16.w),

          // Booking Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  name,
                  style: GoogleFontStyles.h5(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 4.h),

                // Service and Price Row
                Row(
                  children: [
                    Text(
                      service,
                      style: GoogleFontStyles.h6(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      price,
                      style: GoogleFontStyles.h6(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 4.h),

                // Date ===
                Text(
                  date,
                  style: GoogleFontStyles.h6(
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                //  Time ==
                Text(
                  time,
                  style: GoogleFontStyles.h6(
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 16.w),

          // Status and Details Column
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Status
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Status: ',
                      style: GoogleFontStyles.h6(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    TextSpan(
                      text: status,
                      style: GoogleFontStyles.h6(
                        color: _getStatusColor(status),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 8.h),

              // Details Button
              GestureDetector(
                onTap: onDetailsTap,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF55493E),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    'Details',
                    style: GoogleFontStyles.h6(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'completed':
        return Colors.blue;
      case 'in-progress':
        return Colors.green;
      default:
        return Colors.white;
    }
  }
}