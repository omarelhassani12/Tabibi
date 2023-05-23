import 'package:tabibi/logic/controllers/auth_controller.dart';
import 'package:tabibi/utils/theme.dart';
import 'package:tabibi/view/widgets/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckWidget extends StatelessWidget {
  CheckWidget({Key? key}) : super(key: key);
  final controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (_) {
      return Row(
        children: [
          InkWell(
            onTap: () {
              controller.checkBox();
            },
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: controller.isCheckBox
                  ? Get.isDarkMode
                      ? Image.asset('assets/images/check.png')
                      : Icon(
                          Icons.done,
                          color: mainColor,
                        )
                  : Container(),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Row(
            children: [
              TextUtils(
                fontSize: 16,
                color: Get.isDarkMode ? Colors.black : Colors.white,
                fontWeight: FontWeight.normal,
                text: "I accept ",
                underLine: TextDecoration.none,
              ),
              TextUtils(
                fontSize: 16,
                color: Get.isDarkMode ? Colors.black : Colors.white,
                fontWeight: FontWeight.normal,
                text: "terms & conditions",
                underLine: TextDecoration.underline,
              ),
            ],
          ),
        ],
      );
    });
  }
}
