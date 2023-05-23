import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabibi/utils/theme.dart';
import 'package:tabibi/view/widgets/auth/auth_button.dart';
import 'package:tabibi/view/widgets/auth/auth_text_from_field.dart';
import 'package:tabibi/view/widgets/text_utils.dart';

class AddUrgencyPage extends StatefulWidget {
  const AddUrgencyPage({Key? key}) : super(key: key);
  @override
  State<AddUrgencyPage> createState() => _AddUrgencyPage();
}

class _AddUrgencyPage extends State<AddUrgencyPage> {
  // Define the customService field
  String? customService = '';

  final formKey = GlobalKey<FormState>();

  final TextEditingController urganceController = TextEditingController();

  // default value
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          title: Text(
            'Ajouter nouveau urgence',
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
              const SizedBox(
                height: 4,
              ),
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
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 40),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const TextUtils(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          text: "Taper le nom de votre urgence",
                          underLine: TextDecoration.none,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: 340,
                          child: AuthTextFromField(
                            controller: urganceController,
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
                              Icons.local_hospital,
                              color: mainColor,
                              size: 30,
                            ),
                            suffixIcon: const Text(""),
                            hintText: 'Votre urgence',
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        AuthButton(
                          onPressed: () {},
                          text: 'Ajouter',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              /* ContainerUnder(
    text: "Vous avez déja un compte ?",
    textType: "Se connecter",
    onPressed: () {
    Get.offNamed(Routes.loginScreen);
    },
    ),*/
            ],
          ),
        ),
      ),
    );
  }
}
