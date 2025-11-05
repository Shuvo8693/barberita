import 'package:barberita/app/modules/authentication/views/barbar_verification_view.dart';
import 'package:barberita/app/modules/barber_add_service/model/service_item.dart';
import 'package:barberita/app/modules/barber_add_service/views/barber_add_service_view.dart';
import 'package:barberita/app/modules/barber_add_service/widgets/service_item_card.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/bottom_menu/bottom_menu..dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Service Management Screen
class ServiceManagementView extends StatefulWidget {
  const ServiceManagementView({super.key});

  @override
  State<ServiceManagementView> createState() => _ServiceManagementViewState();
}

class _ServiceManagementViewState extends State<ServiceManagementView> {
  // Dummy data for services
  final List<ServiceItem> _serviceItems = [
    ServiceItem(
      id: '1',
      imagePath: 'assets/images/service1.jpg',
      title: 'Marty\'s Barbershop',
      subtitle: 'Haircut',
      status: 'Open Now',
      priceRange: '\$2.99-\$500',
      isActive: true,
    ),
    ServiceItem(
      id: '2',
      imagePath: 'assets/images/service2.jpg',
      title: 'Marty\'s Barbershop',
      subtitle: 'Beard Trim',
      status: 'Open Now',
      priceRange: '\$5.99-\$300',
      isActive: true,
    ),
    ServiceItem(
      id: '3',
      imagePath: 'assets/images/service3.jpg',
      title: 'Marty\'s Barbershop',
      subtitle: 'Hair Styling',
      status: 'Closed',
      priceRange: '\$10.99-\$800',
      isActive: false,
    ),
    ServiceItem(
      id: '4',
      imagePath: 'assets/images/service4.jpg',
      title: 'Marty\'s Barbershop',
      subtitle: 'Hair Wash',
      status: 'Open Now',
      priceRange: '\$3.99-\$200',
      isActive: true,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(child: BottomMenu(1)),
      appBar: CustomAppBar(title: 'Service Management',),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Active Hour Section
            Row(
              children: [
                Text('Active Hour:', style: GoogleFontStyles.h6(color: Colors.white.withOpacity(0.7))),
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: () => _showEditHourDialog(),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2C2E),
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('9:00 AM - 9:00 PM', style: GoogleFontStyles.h6(color: Colors.white)),
                        SizedBox(width: 8.w),
                        Icon(Icons.edit, color: const Color(0xFFE6C4A3), size: 16.sp),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),

            // Add Your Service Section
            Text('Your added Services', style: GoogleFontStyles.h5(color: Colors.white, fontWeight: FontWeight.w600)),

            SizedBox(height: 16.h),

            // Latest Upload Container
            Container(
              height: 400.h,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2E),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Latest Upload', style: GoogleFontStyles.h6(color: Colors.white.withOpacity(0.7))),
                  SizedBox(height: 10.h),

                  // Service Items ListView
                  Expanded(
                    child: ListView.builder(
                      itemCount: _serviceItems.length,
                      itemBuilder: (context, index) {
                        final service = _serviceItems[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: index == _serviceItems.length - 1 ? 0 : 16.h),
                          child: ServiceItemCard(
                            service: service,
                            onToggle: (value) {
                              setState(() {
                                _serviceItems[index] = service.copyWith(isActive: value);
                              });
                            },
                            onEdit: () {
                              // Handle edit
                              print('Edit service: ${service.title}');
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            // Add More Service Button
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const BarberAddServiceView()));
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.white, size: 24.sp),
                    SizedBox(width: 8.w),
                    Text('Add More Service', style: GoogleFontStyles.h5(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditHourDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2E),
        title: Text('Edit Your Active Hour', style: GoogleFontStyles.h4(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTimeField('Start Time', '09:00 AM'),
            SizedBox(height: 16.h),
            _buildTimeField('End Time', '09:00 PM'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFontStyles.h5(color: Colors.white.withOpacity(0.7))),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(color: const Color(0xFF55493E), borderRadius: BorderRadius.circular(6.r)),
              child: Text('Update', style: GoogleFontStyles.h5(color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeField(String label, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFontStyles.h6(color: Colors.white.withOpacity(0.7))),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Expanded(child: Text(time, style: GoogleFontStyles.h5(color: Colors.white))),
              Icon(Icons.access_time, color: Colors.white.withOpacity(0.5), size: 20.sp),
            ],
          ),
        ),
      ],
    );
  }
}