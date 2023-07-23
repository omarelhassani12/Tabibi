import 'package:flutter/services.dart';
import 'package:tabibi/logic/controllers/auth_controller.dart';
import 'package:tabibi/routes/routes.dart';
import 'package:tabibi/utils/my_string.dart';
import 'package:tabibi/utils/theme.dart';
import 'package:tabibi/view/widgets/auth/auth_button.dart';
import 'package:tabibi/view/widgets/auth/auth_text_from_field.dart';
import 'package:tabibi/view/widgets/auth/container_under.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreenDoctor extends StatefulWidget {
  const SignUpScreenDoctor({Key? key}) : super(key: key);

  @override
  State<SignUpScreenDoctor> createState() => _SignUpScreenDoctorState();
}

class _SignUpScreenDoctorState extends State<SignUpScreenDoctor> {
  final fromkey = GlobalKey<FormState>();

  final TextEditingController nomPrenomController = TextEditingController();

  final TextEditingController cniController = TextEditingController();

  final TextEditingController teleController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final formData =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (formData != null) {
      print(formData);
    } else {}

    formData!['nomPrenom'] = nomPrenomController.text;

    formData['email'] = emailController.text;

    formData['cni'] = cniController.text;

    formData['password'] = passwordController.text;

    formData['telephone'] = teleController.text;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          title: Text(
            'signUp'.tr,
            style: TextStyle(
              color: mainColor,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: mainColor,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 1.23,
                child: Form(
                  key: fromkey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 80,
                            width: 360,
                            alignment: Alignment.center,
                            child: SizedBox(
                              child: Image.asset(
                                'assets/images/TABIBI.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 340,
                        child: AuthTextFromField(
                          controller: nomPrenomController,
                          obscureText: false,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'enterValidFullName'.tr;
                            } else if (!RegExp(r'^[a-zA-Z]+$')
                                .hasMatch(value)) {
                              return 'enterAlphabeticCharactersOnly'.tr;
                            } else {
                              return null;
                            }
                          },
                          prefixIcon: Icon(
                            Icons.person,
                            color: mainColor,
                            size: 25,
                          ),
                          suffixIcon: const Text(""),
                          hintText: 'fullName'.tr,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 340,
                        child: AuthTextFromField(
                          controller: emailController,
                          obscureText: false,
                          validator: (value) {
                            if (!RegExp(validationEmail).hasMatch(value)) {
                              return 'enterValidEmail'.tr;
                            } else {
                              return null;
                            }
                          },
                          prefixIcon: Icon(
                            Icons.email,
                            color: mainColor,
                            size: 25,
                          ),
                          suffixIcon: const Text(""),
                          hintText: 'emailHint'.tr,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 340,
                        child: AuthTextFromField(
                          controller: cniController,
                          obscureText: false,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'enterValidCni'.tr;
                            } else if (!RegExp(r'^[a-zA-Z\d]+$')
                                .hasMatch(value)) {
                              return 'enterAlphabeticAndNumericCharactersOnly'
                                  .tr;
                            } else {
                              return null;
                            }
                          },
                          prefixIcon: Icon(
                            Icons.credit_card,
                            color: mainColor,
                            size: 25,
                          ),
                          suffixIcon: const Text(""),
                          hintText: 'nationalIdentityCard'.tr,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 340,
                        child: GetBuilder<AuthController>(
                          builder: (_) {
                            return AuthTextFromField(
                              controller: passwordController,
                              obscureText:
                                  controller.isVisibility ? false : true,
                              validator: (value) {
                                if (value.toString().length < 6) {
                                  return 'passwordMinLength'.tr;
                                } else {
                                  return null;
                                }
                              },
                              prefixIcon: Icon(
                                Icons.lock,
                                color: mainColor,
                                size: 25,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  controller.visiblity();
                                },
                                icon: controller.isVisibility
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: mainColor,
                                        size: 25,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: mainColor,
                                        size: 25,
                                      ),
                              ),
                              hintText: 'passwordHint'.tr,
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 340,
                        height: 53,
                        child: TextFormField(
                          controller: teleController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'\d')),
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (value) {
                            formData['telephone'] = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'telephoneRequired'.tr;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            prefixIcon: Icon(
                              Icons.phone,
                              size: 25,
                              color: mainColor,
                            ),
                            hintText: "phoneNumber".tr,
                            hintStyle: const TextStyle(
                              color: Colors.black45,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 20),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 55,
                      ),
                      AuthButton(
                        onPressed: () {
                          if (nomPrenomController.text.isEmpty ||
                              cniController.text.isEmpty ||
                              teleController.text.isEmpty ||
                              passwordController.text.isEmpty ||
                              emailController.text.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'emptyFields'.tr,
                                    textAlign: TextAlign.center,
                                  ),
                                  titleTextStyle:
                                      const TextStyle(color: Colors.red),
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                        size: 48,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'fillAllFields'.tr,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            Get.offNamed(
                              Routes.singUpDoctorPage,
                              arguments: formData,
                            );
                          }
                        },
                        text: "next".tr,
                      ),
                    ],
                  ),
                ),
              ),
              ContainerUnder(
                text: "alreadyHaveAccount".tr,
                textType: "signIn".tr,
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
