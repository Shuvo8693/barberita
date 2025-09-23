import 'package:barberita/common/bottom_menu/bottom_menu..dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/customer_profile_controller.dart';

class CustomerProfileView extends GetView<CustomerProfileController> {
  const CustomerProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(child: BottomMenu(2)),
      appBar: AppBar(
        title: const Text('CustomerProfileView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CustomerProfileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
