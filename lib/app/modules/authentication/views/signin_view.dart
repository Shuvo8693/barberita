import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SigninView extends GetView {
  const SigninView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SigninView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SigninView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
