import 'package:barberita/common/bottom_menu/bottom_menu..dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/barber_add_service_controller.dart';

class BarberAddServiceView extends GetView<BarberAddServiceController> {
  const BarberAddServiceView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(child: BottomMenu(1)),
      appBar: AppBar(
        title: const Text('BarberAddServiceView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BarberAddServiceView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
