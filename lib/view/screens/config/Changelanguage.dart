import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageDropdown extends StatelessWidget {
  const LanguageDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: Get.locale!.languageCode,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: Colors.grey[400],
      ),
      onChanged: (String? languageCode) {
        if (languageCode != null) {
          Get.updateLocale(Locale(languageCode));
        }
      },
      items: <String>['en', 'fr'] // replace with your supported languages
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value.toUpperCase(),
            style: const TextStyle(fontSize: 16),
          ),
        );
      }).toList(),
    );
  }
}
