import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FormFields extends StatelessWidget {
  final TextEditingController controller;
  final IconData data;
  final String txtHint;
  bool obsecure = true;

  FormFields({required Key key, required this.controller, required this.data, required this.txtHint, required this.obsecure})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      child: TextFormField(
        controller: controller,
        obscureText: obsecure,
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              data,
              color: Colors.grey,
            ),
            hintText: txtHint),
      ),
    );
  }
}
