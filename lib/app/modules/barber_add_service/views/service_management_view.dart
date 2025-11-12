import 'package:barberita/app/modules/authentication/views/barbar_verification_view.dart';
import 'package:barberita/app/modules/barber_add_service/controllers/barber_add_service_controller.dart';
import 'package:barberita/app/modules/barber_add_service/model/barber_added_service_model.dart';
import 'package:barberita/app/modules/barber_add_service/model/service_item.dart';
import 'package:barberita/app/modules/barber_add_service/views/barber_add_service_view.dart';
import 'package:barberita/app/modules/barber_add_service/widgets/service_item_card.dart';
import 'package:barberita/app/routes/app_pages.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/bottom_menu/bottom_menu..dart';
import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:barberita/common/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// Service Management Screen
class ServiceManagementView extends StatefulWidget {
  const ServiceManagementView({super.key});

  @override
  State<ServiceManagementView> createState() => _ServiceManagementViewState();
}

class _ServiceManagementViewState extends State<ServiceManagementView> {
  final BarberAddServiceController _serviceController = Get.put(BarberAddServiceController());

  @override
  void initState() {
    super.initState();
    _serviceController.fetchAddedServices();
  }

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
            Obx((){
              BarberAddedServiceData?  addedServices = _serviceController.barberAddedServiceModel.value.data;
              if(_serviceController.isLoadingUserReview.value){
                return Center( child: CupertinoActivityIndicator());
              }
              List<BarberServiceItem> servicesItem = addedServices?.services??[];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ========= working hour =======
                  // Row(
                  //   children: [
                  //     Text('Active Hour: ', style: GoogleFontStyles.h6(color: Colors.white.withOpacity(0.7))),
                  //     SizedBox(width: 8.w),
                  //     GestureDetector(
                  //       onTap: () => _showEditHourDialog(), //<=============== Active hour dialog =====
                  //       child: Container(
                  //         padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  //         decoration: BoxDecoration(
                  //           color: const Color(0xFF2C2C2E),
                  //           borderRadius: BorderRadius.circular(6.r),
                  //           border: Border.all(color: Colors.white.withOpacity(0.3)),
                  //         ),
                  //         child: Row(
                  //           mainAxisSize: MainAxisSize.min,
                  //           children: [
                  //             Text(addedServices?.workingHours??'', style: GoogleFontStyles.h6(color: Colors.white)),
                  //             SizedBox(width: 8.w),
                  //             Icon(Icons.edit, color: const Color(0xFFE6C4A3), size: 16.sp),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  SizedBox(height: 24.h),

                  // Add Your Service Section
                  Text('Your added Services', style: GoogleFontStyles.h5(color: Colors.white, fontWeight: FontWeight.w600)),

                  SizedBox(height: 16.h),

                  // Latest Upload Container
                  if(servicesItem.isNotEmpty)
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
                            itemCount: servicesItem.length,
                            itemBuilder: (context, index) {
                              final serviceIndex = servicesItem[index];
                              return Padding(
                                padding: EdgeInsets.only(bottom: index == servicesItem.length - 1 ? 0 : 16.h),
                                child: ServiceItemCard(
                                  service: serviceIndex,
                                  onToggle: (value) async {
                                   await _serviceController.toggleServicesStatus(serviceId: serviceIndex.id,voidCallBack: (){
                                      setState(() {
                                        servicesItem[index].active = value;
                                      });
                                    });
                                  },
                                  onEdit: () {
                                    // Handle edit
                                     Get.toNamed(Routes.UPDATESERVICE,arguments: {'serviceId':serviceIndex.id,'isEdit':true});
                                    print('Edit service: ${serviceIndex.serviceName}');
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            ),
            SizedBox(height: 20.h),
            // Add More Service Button
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.UPDATESERVICE,arguments: {'serviceId':'','isEdit':false});
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

  void _showEditHourDialog({BarberAddedServiceData?  addedServices}) {
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
        Text(
          label,
          style: GoogleFontStyles.h6(color: Colors.white.withOpacity(0.7)),
        ),
        SizedBox(height: 8.h),
        CustomTextField(
          hintText: time,
          controller: TextEditingController(text: time),
          readOnly: true,
          suffixIcon: Icon(
            Icons.access_time,
            color: Colors.white.withOpacity(0.5),
            size: 20.sp,
          ),
        ),
      ],
    );
  }
}