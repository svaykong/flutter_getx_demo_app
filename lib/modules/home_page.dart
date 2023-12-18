import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../modules/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: SafeArea(
          child: Container(),
        ),
      ),
    );
  }
}
