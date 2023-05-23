import 'package:flutter/material.dart';
import 'package:tabibi/routes/routes.dart';
import 'package:tabibi/utils/theme.dart';
import 'package:get/get.dart';
import 'package:tabibi/view/widgets/text_utils.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 70,
                  width: 190,
                  child: SizedBox(
                    child: Image.asset(
                      'assets/images/TABIBI.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 320,
                ),
                 const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextUtils(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      text: "Bienvenue",
                      color: Colors.lightBlueAccent,
                      underLine: TextDecoration.none,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 80,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        mainColor, // changed to use the imported color from the theme
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () {
                    Get.offNamed(Routes.loginScreen);
                  },
                  child: const TextUtils(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    text: "Commencer",
                    underLine: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
