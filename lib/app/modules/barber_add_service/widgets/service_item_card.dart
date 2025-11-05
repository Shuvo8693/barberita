// Service Item Card Widget
import 'package:barberita/app/data/api_constants.dart';
import 'package:barberita/app/modules/barber_add_service/model/barber_added_service_model.dart';
import 'package:barberita/app/modules/barber_add_service/model/service_item.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceItemCard extends StatelessWidget {
  final BarberServiceItem service;
  final Function(bool) onToggle;
  final VoidCallback onEdit;

  const ServiceItemCard({
    super.key,
    required this.service,
    required this.onToggle,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Service Image
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Image.asset('${ApiConstants.baseUrl}${service.serviceImage??''}',
            width: 60.w,
            height: 60.h,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 60.w,
                height: 60.h,
                color: Colors.grey[600],
                child: Icon(Icons.cut, color: Colors.white, size: 30.sp),
              );
            },
          ),
        ),
        SizedBox(width: 12.w),
        // Service Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                service.serviceName??'',
                style: GoogleFontStyles.h6(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Hair Cut',
                style: GoogleFontStyles.customSize(
                  size: 10.sp,
                  color: const Color(0xFFE6C4A3),
                ),
              ),
              Text(
                service.active==true ?'Open Now':'Closed',
                style: GoogleFontStyles.customSize(
                  size: 10.sp,
                  color: service.active==true ? Colors.green : Colors.red,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Price Range: ${service.price}',
                style: GoogleFontStyles.customSize(
                  size: 9.sp,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),

        // Toggle and Edit
        Column(
          children: [
            Switch(
              value: service.active??false,
              onChanged: onToggle,
              activeColor: Colors.green,
              inactiveThumbColor: Colors.grey,
            ),
            SizedBox(height: 4.h),
            GestureDetector(
              onTap: onEdit,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF55493E),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.edit, color: Colors.white, size: 12.sp),
                    SizedBox(width: 4.w),
                    Text(
                      'Edit',
                      style: GoogleFontStyles.customSize(
                        size: 10.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}