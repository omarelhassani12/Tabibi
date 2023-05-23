import 'package:tabibi/utils/my_string.dart';
import 'package:tabibi/utils/theme.dart';
import 'package:tabibi/view/widgets/auth/auth_button.dart';
import 'package:tabibi/view/widgets/auth/auth_text_from_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          title: Text(
            'Forget Password',
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
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "Si vous voulez récupérer votre compte, veuillez fournir votre identifiant e-mail ci-dessous.. ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  // Replace this with your own image
                  Image.asset(
                    "assets/images/forgetpass_copy.png",
                    width: 250,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  AuthTextFromField(
                    controller: emailController,
                    obscureText: false,
                    validator: (value) {
                      if (!RegExp(validationEmail).hasMatch(value)) {
                        //if value != validationName
                        return 'Enter valid email';
                      } else {
                        return null;
                      }
                    },
                    prefixIcon: Get.isDarkMode
                        ? Image.asset('assets/images/email.png')
                        : Icon(
                            Icons.email,
                            color: mainColor,
                            size: 30,
                          ),
                    suffixIcon: const Text(""),
                    hintText: 'Email',
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  AuthButton(
                    text: "Envoyer",
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
