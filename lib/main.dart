import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'themes/colors_theme.dart';

void main() async {
  // To load the .env file contents into dotenv.
  // NOTE: fileName defaults to .env and can be omitted in this case.
  // Ensure that the filename corresponds to the path in step 1 and 2.
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Getx Demo App',
      theme: ThemeColor().themeData,
      initialRoute: AppRoutes.home,
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}
