// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

// class ThemeController extends GetxController {
//   final GetStorage boxStorage = GetStorage();
//   final key = "isDarkMode";
//   final defaultThemeMode = ThemeMode.dark;

//   @override
//   void onInit() {
//     super.onInit();
//     Get.changeThemeMode(
//         getThemeDataFromBox() ? ThemeMode.light : ThemeMode.dark);
//   }

//   saveThemeDataInBox(bool isDark) {
//     boxStorage.write(key, isDark);
//     update();
//   }

//   bool getThemeDataFromBox() {
//     return boxStorage.read(key) ?? false;
//   }

//   ThemeMode get themeDataGet {
//     bool isDarkMode = getThemeDataFromBox();
//     return isDarkMode ? ThemeMode.dark : ThemeMode.light;
//   }

//   void changeTheme() {
//     bool isDarkMode = getThemeDataFromBox();
//     saveThemeDataInBox(!isDarkMode);
//     Get.changeThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);
//   }
// }
