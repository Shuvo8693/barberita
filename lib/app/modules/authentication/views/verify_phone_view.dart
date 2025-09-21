import 'package:flutter/material.dart';

import 'package:get/get.dart';

class VerifyPhoneView extends GetView {
  const VerifyPhoneView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VerifyPhoneView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'VerifyPhoneView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
