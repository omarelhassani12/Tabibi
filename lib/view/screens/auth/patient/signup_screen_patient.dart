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

class SignUpScreenPatient extends StatelessWidget {
  SignUpScreenPatient({Key? key}) : super(key: key);

  final fromkey = GlobalKey<FormState>();

  final TextEditingController nomPrenomController = TextEditingController();
  final TextEditingController cniController = TextEditingController();
  final TextEditingController teleController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final String? dropdownValue =
        ModalRoute.of(context)?.settings.arguments as String?;
    print(dropdownValue);
    Map<String, dynamic> formData = {};
          // To store the value of the zero input
      formData['type'] = dropdownValue;
          // To store the value of the first input
      formData['nomPrenom'] = nomPrenomController.text;

          // To store the value of the second input
      formData['email'] = emailController.text;

          // To store the value of the third input
      formData['cni'] = cniController.text;

          // To store the value of the fourth input
      formData['password'] = passwordController.text;

          // To store the value of the fifth input
      formData['telephone'] = teleController.text;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          title: Text(
            'Inscrivez-vous',
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
                              return 'Entrez un nom complete valide';
                            } else if (!RegExp(r'^[a-zA-Z]+$')
                                .hasMatch(value)) {
                              // The input contains non-alphabet characters
                              return 'Entrez des caractères alphabétiques seulement';
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
                          hintText: 'nom et prenom',
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
                              return 'Entrez une adresse email valide';
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
                          hintText: 'Email',
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
                              return 'Entrez un numero de catre d\'identite valide valide';
                            } else if (!RegExp(r'^[a-zA-Z\d]+$')
                                .hasMatch(value)) {
                              // The input contains non-alphanumeric characters
                              return 'Entrez des caractères alphabétiques et numériques seulement';
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
                          hintText: 'Carte nationale d\'identité',
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
                                  //if value != validationName
                                  return 'Le mot de passe doit comporter au moins 6 caractères';
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
                              hintText: 'Mot de passe',
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'telephone is required';
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
                            hintText: "Numéro de téléphone",
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
                          Get.offNamed(
                            Routes.singUpPatientPage,
                            arguments: formData,
                          );
                        },
                        text: "Suivante",
                      ),
                    ],
                  ),
                ),
              ),
              ContainerUnder(
                text: "Vous avez déja un compte ?",
                textType: "Se connecter",
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
