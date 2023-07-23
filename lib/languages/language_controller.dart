import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabibi/pref_service.dart';

class LanguageController extends GetxController {
  final PrefService _prefService = PrefService();

  var savedLang = 'fr'.obs; // Change 'FR' to 'fr'

  saveLocale() {
    _prefService.createString('locale', savedLang.value);
  }

  Future<void> setLocale() async {
    _prefService.readString('locale').then((value) {
      if (value != null && value.isNotEmpty) { // Update the condition
        Get.updateLocale(Locale(value.toString().toLowerCase()));
        savedLang.value = value.toString();
      }
    });
  }

  @override
  void onInit() {
    setLocale();
    super.onInit();
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:tabibi/pref_service.dart';

// class LanguageController extends GetxController {
//   final PrefService _prefService = PrefService();

//   var savedLang = 'FR'.obs;

//   saveLocale() {
//     _prefService.createString('locale', savedLang.value);
//   }

//   Future<void> setLocale() async {
//     _prefService.readString('locale').then((value) {
//       if (value != '' && value != null) {
//         Get.updateLocale(Locale(value.toString().toLowerCase()));
//         savedLang.value = value.toString();
//         //update();
//       }
//     });
//   }

//   @override
//   void onInit() async {
//     setLocale();
//     super.onInit();
//   }
// }
