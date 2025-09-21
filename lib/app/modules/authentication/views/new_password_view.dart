import 'package:flutter/material.dart';

import 'package:get/get.dart';

class NewPasswordView extends GetView {
  const NewPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NewPasswordView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NewPasswordView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
