import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'all_movies_controller.dart';
import '../../utils/logger.dart';

class AllMoviesPage extends StatelessWidget {
  const AllMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Movies'),
      ),
      body: SafeArea(
        child: GetBuilder<AllMoviesController>(
          builder: (controller) {
            'isLoading: ${controller.isLoading}'.log();
            if (controller.isLoading) {
              return const CircularProgressIndicator();
            }

            if (controller.errMsg.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(controller.errMsg),
              );
            }
            return const Text('Some value');
          },
        ),
      ),
    );
  }
}
