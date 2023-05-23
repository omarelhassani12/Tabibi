import 'package:tabibi/utils/theme.dart';
import 'package:tabibi/view/widgets/text_utils.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const AuthButton({required this.text, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: mainColor,
        minimumSize: const Size(300, 50),
      ),
      child: TextUtils(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          text: text,
          underLine: TextDecoration.none),
    );
  }
}
