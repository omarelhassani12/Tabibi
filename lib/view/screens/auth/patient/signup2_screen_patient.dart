import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tabibi/routes/routes.dart';
import 'package:tabibi/services/restapi.dart';
import 'package:tabibi/view/screens/auth/login_screen.dart';
import 'package:tabibi/view/widgets/auth/auth_button.dart';
import 'package:tabibi/view/widgets/auth/container_under.dart';

class SingUpPatientPage extends StatefulWidget {
  const SingUpPatientPage({Key? key}) : super(key: key);

  @override
  State<SingUpPatientPage> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SingUpPatientPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();

  String? dropdownValue;

  Future<void> doRegister(Map<String, dynamic> formData) async {
    var res = await userRegister(
      formData['type'],
      formData['nomPrenom'],
      formData['email'],
      formData['cni'],
      formData['password'],
      formData['telephone'],
      formData['urgence'],
      formData['sexe'],
      formData['age'],
    );

    if (res['success']) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    } else {
      String errorMsg = '';
      if (res['message'] ==
          'The email you entered is already in use. Please try with a different email address.') {
        errorMsg = 'This email is already registered.';
      } else {
        errorMsg = 'An error occurred. Please try by another email.';
      }

      Fluttertoast.showToast(
        msg: errorMsg,
        textColor: Colors.red,
      );
    }
  }

  // default value
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> formData = Get.arguments;
    print(formData);
    // To store the value of the zero input
    formData['age'] = controller.text;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 265,
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
                height: 380,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 40),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 10),
                            Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade200,
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    hint:
                                        const Text('Sélectionner une urgence'),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 0,
                                      ),
                                      border: InputBorder.none,
                                      // hintText: 'Services',
                                    ),
                                    value: null,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue = newValue!;
                                        formData['urgence'] = dropdownValue;
                                      });
                                      if (dropdownValue == 'Autre') {
                                        Navigator.pushNamed(
                                            context, Routes.addUrgencyPage);
                                      }
                                    },
                                    items: <String>[
                                      'Traumatique',
                                      'Gastro/uro',
                                      'Gynécologique',
                                      'Neurologique',
                                      'Respiratoire',
                                      'Cardiaque',
                                      'Allergique',
                                      'Morsure/piqure',
                                      'Psychiatrique',
                                      'Autre',
                                    ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      },
                                    ).toList(),
                                    menuMaxHeight: 200,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 10),
                            Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade200,
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    hint: const Text('Sélectionner le sexe'),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 0),
                                      border: InputBorder.none,
                                    ),
                                    value: null,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue = newValue!;
                                        formData['sexe'] = dropdownValue;
                                      });
                                    },
                                    items: <String>[
                                      'Homme',
                                      'Femme',
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
                                  top:
                                      44, // Adjusted to account for the height of the dropdown menu
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
                          height: 28,
                        ),
                        SizedBox(
                          height: 70,
                          child: TextFormField(
                            controller: controller,
                            decoration: InputDecoration(
                              labelText: "age",
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,2}')),
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'age is required';
                              }
                              return null;
                            },
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                            maxLength: 3,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        AuthButton(
                          onPressed: () async {
                            await doRegister(Get.arguments);
                          },
                          text: 'S\'incrire',
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
