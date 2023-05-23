import 'package:flutter/material.dart';
import 'package:tabibi/utils/theme.dart';
import 'package:tabibi/view/widgets/text_utils.dart';

class ContainerUnder extends StatelessWidget {
  final String text;
  final String textType;
  final Function() onPressed;

  const ContainerUnder({
    required this.text,
    required this.textType,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextUtils(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.normal,
            text: text,
            underLine: TextDecoration.none,
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              textType,
              style: TextStyle(
                color: mainColor,
                fontWeight: FontWeight.bold,
                fontSize: 15,
                decoration: TextDecoration.underline,
                decorationColor: mainColor, // Change underline color here
                //decorationThickness: 2.0, // Change underline thickness here
              ),
            ),
          ),
          /*TextButton(
            onPressed: onPressed,
            child: TextUtils(
              fontSize: 15,
              color: mainColor,
              fontWeight: FontWeight.bold,
              text: textType,
              underLine:  TextDecoration.underline,

            ),
          ),*/
        ],
      ),
    );
  }
}
