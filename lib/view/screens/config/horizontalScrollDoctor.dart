import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabibi/routes/routes.dart';
import 'package:tabibi/utils/theme.dart';
import 'package:tabibi/view/widgets/text_utils.dart';

// horizontal scroll

class HorizontalScrollDoctor extends StatelessWidget {
  const HorizontalScrollDoctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          SizedBox(
            height: 170,
            // width: 300,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.addUrgencyPage);
                    },
                    child: Container(
                      width: 120,
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: greenClr,
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextUtils(
                              fontSize: 60,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              text: '12',
                              underLine: TextDecoration.none),
                          // Image.asset(
                          //   'assets/images/Cardiologue.png',
                          //   width: 80,
                          //   height: 90,
                          // ),
                          SizedBox(height: 8),
                          Text(
                            'Mars',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.addUrgencyPage);
                    },
                    child: Container(
                      width: 120,
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: greenClr,
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextUtils(
                              fontSize: 60,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              text: '12',
                              underLine: TextDecoration.none),
                          // Image.asset(
                          //   'assets/images/Cardiologue.png',
                          //   width: 80,
                          //   height: 90,
                          // ),
                          SizedBox(height: 8),
                          Text(
                            'Mars',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.addUrgencyPage);
                    },
                    child: Container(
                      width: 120,
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: greenClr,
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextUtils(
                              fontSize: 60,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              text: '12',
                              underLine: TextDecoration.none),
                          // Image.asset(
                          //   'assets/images/Cardiologue.png',
                          //   width: 80,
                          //   height: 90,
                          // ),
                          SizedBox(height: 8),
                          Text(
                            'Mars',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.addUrgencyPage);
                    },
                    child: Container(
                      width: 120,
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: greenClr,
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextUtils(
                              fontSize: 60,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              text: '12',
                              underLine: TextDecoration.none),
                          // Image.asset(
                          //   'assets/images/Cardiologue.png',
                          //   width: 80,
                          //   height: 90,
                          // ),
                          SizedBox(height: 8),
                          Text(
                            'Mars',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.addUrgencyPage);
                    },
                    child: Container(
                      width: 120,
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: greenClr,
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextUtils(
                              fontSize: 60,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              text: '12',
                              underLine: TextDecoration.none),
                          // Image.asset(
                          //   'assets/images/Cardiologue.png',
                          //   width: 80,
                          //   height: 90,
                          // ),
                          SizedBox(height: 8),
                          Text(
                            'Mars',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
