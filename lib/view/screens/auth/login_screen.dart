import 'package:tabibi/logic/controllers/auth_controller.dart';
import 'package:tabibi/routes/routes.dart';
import 'package:tabibi/services/restapi.dart';
import 'package:tabibi/utils/my_string.dart';
import 'package:tabibi/utils/theme.dart';
import 'package:tabibi/view/screens/doctor/main_screen_doctor.dart';
import 'package:tabibi/view/screens/patient/main_screen_patient.dart';
import 'package:tabibi/view/widgets/auth/auth_text_from_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final fromkey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final controller = Get.find<AuthController>();
  static Map<String, dynamic> userD = {};

  Future<void> doLogin(String email, String password) async {
    final res = await userLogin(email.trim(), password.trim());
    print(res.toString());
    if (res['success']) {
      print("this is res['data'] + ${res['data']}");
      final userData = res['data'] as List<dynamic>;
      final user = userData.isNotEmpty ? userData[0] : null;
      if (user != null) {
        if (user['role'] == 'Patient') {
          // Handle logic for Patient user
          // Set user data
          final route = MaterialPageRoute(builder: (_) => const MainScreen());
          Navigator.pushReplacement(context, route);

          // Save user data to shared preferences
          await _parseResponse(user['username'], user['email']);
        } else if (user['role'] == 'Doctor') {
          // Handle logic for Doctor user
          // Set user data
          final route =
              MaterialPageRoute(builder: (_) => const MainScreenDoctor());
          Navigator.pushReplacement(context, route);

          // Save user data to shared preferences
          await _parseResponse(user['username'], user['email']);
        } else {
          Fluttertoast.showToast(
              msg: 'Invalid user role', textColor: Colors.red);
        }
      } else {
        Fluttertoast.showToast(msg: 'User not found', textColor: Colors.red);
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Invalid email or password', textColor: Colors.red);
    }
  }

  Future<void> _parseResponse(String username, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save the user data to Shared Preferences
    await prefs.setString('name', username);
    await prefs.setString('email', email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      height: 330,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage("assets/images/background_login.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 300,
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: 20),
                                Text(
                                  'Connexion',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: mainColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 25),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: AuthTextFromField(
                                    controller: _emailController,
                                    obscureText: false,
                                    validator: (value) {
                                      if (!RegExp(validationEmail)
                                          .hasMatch(value)) {
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
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: GetBuilder<AuthController>(
                                    builder: (_) {
                                      return AuthTextFromField(
                                        controller: _passwordController,
                                        obscureText: controller.isVisibility
                                            ? false
                                            : true,
                                        validator: (value) {
                                          if (value.toString().length < 6) {
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
                                                )
                                              : Icon(
                                                  Icons.visibility,
                                                  color: mainColor,
                                                ),
                                        ),
                                        hintText: 'Mot de passe',
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      print("onpress");
                                      await doLogin(
                                        _emailController.text.trim(),
                                        _passwordController.text,
                                      );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              mainColor),
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                        const EdgeInsets.symmetric(
                                            vertical: 15.0),
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      'Se connecter',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.forgetPasswordScreen);
                                  },
                                  child: const Text(
                                    'Forgot password?',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                // Spacer(),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Vous n\'avez pas un compte?',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Get.toNamed(Routes.signUpScreen);
                                      },
                                      child: Text(
                                        'S\'inscrire',
                                        style: TextStyle(
                                          color: mainColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
