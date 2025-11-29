import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planify/routes/app_pages.dart';
import 'package:planify/routes/app_routes.dart';

import 'core/constants/app_strings.dart';
import 'core/constants/app_colors.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        fontFamily: "Poppins",
      ),

      // home: Scaffold(
      //   appBar: AppBar(title: Text(AppStrings.appName)),
      //   body: Center(child: Text('Bienvenue')),
      // ),
      initialRoute: AppRoutes.initial,
      getPages: AppPages.pages,
    );
  }
}
