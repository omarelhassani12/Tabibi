import 'package:tabibi/routes/routes.dart';
import 'package:tabibi/utils/theme.dart';
import 'package:tabibi/view/widgets/auth/auth_button.dart';
import 'package:tabibi/view/widgets/auth/container_under.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();

  String? dropdownValue;
  Map<String, dynamic> formData = {};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 320,
                child: Image.asset(
                  'assets/images/background_login.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                width: double.infinity,
                height: 320,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 35,
                                alignment: Alignment.center,
                                child: Text(
                                  'signUp'.tr,
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: mainColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Column(
                          children: [
                            Text(
                              'chooseServiceNature'.tr,
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 15),
                            Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade200,
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    hint: Text('selectService'.tr),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 0),
                                      border: InputBorder.none,
                                    ),
                                    value: dropdownValue,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue = newValue;
                                        formData['type'] = dropdownValue;
                                      });
                                    },
                                    items: <String>[
                                      'patient',
                                      'doctor',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    menuMaxHeight: 200,
                                  ),
                                ),
                                Positioned(
                                  top: 44,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.shade200,
                                    ),
                                    height: 200,
                                    width:
                                        MediaQuery.of(context).size.width - 32,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        AuthButton(
                          onPressed: () {
                            if (dropdownValue == null) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('serviceNotSelected'.tr),
                                    content: Text(
                                      'selectServiceBeforeContinuing'.tr,
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('OK'.tr),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              // Check if formData is not null
                              if (formData.isNotEmpty) {
                                if (dropdownValue == 'patient') {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.signUpScreenPatient,
                                    arguments: formData,
                                  );
                                } else if (dropdownValue == 'doctor') {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.signUpScreenDoctor,
                                    arguments: formData,
                                  );
                                }
                              } else {
                                // Handle null case of formData
                                print('formData is empty');
                              }
                            }
                          },
                          text: 'next'.tr,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ContainerUnder(
                text: "alreadyHaveAccount".tr,
                textType: "login".tr,
                onPressed: () {
                  Get.offNamed(Routes.loginScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
