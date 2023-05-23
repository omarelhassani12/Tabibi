import 'package:tabibi/logic/bindings/auth_binding.dart';
import 'package:tabibi/view/screens/auth/doctor/signup2_screen_doctor.dart';
import 'package:tabibi/view/screens/auth/doctor/signup_screen_doctor.dart';
import 'package:tabibi/view/screens/auth/forget_password.dart';
import 'package:tabibi/view/screens/auth/patient/add_urgency_page.dart';
import 'package:tabibi/view/screens/auth/patient/signup2_screen_patient.dart';
import 'package:tabibi/view/screens/doctor/main_screen_doctor.dart';
import 'package:tabibi/view/screens/patient/main_screen_patient.dart';
import 'package:tabibi/view/screens/patient/urgancey_detail.dart';
import 'package:tabibi/view/screens/welcome_screen.dart';
import 'package:tabibi/view/screens/auth/login_screen.dart';
import 'package:tabibi/view/screens/auth/signup_screen.dart';
import 'package:tabibi/view/screens/auth/patient/signup_screen_patient.dart';

import 'package:get/get.dart';

class AppRoutes {
  //initialRoute
  static const welcome = Routes.welcomeScreen;
  //getPages
//the meaning of static word is that we can touch it(the static word) from any place
  static final routes = [
    GetPage(
      name: Routes.welcomeScreen,
      page: () => const WelcomeScreen(),
    ),
    GetPage(
      name: Routes.loginScreen,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.signUpScreen,
      page: () => const SignUpScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.forgetPasswordScreen,
      page: () => ForgetPasswordScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.signUpScreenPatient,
      page: () => SignUpScreenPatient(),
      binding: AuthBinding(),
    ),

    GetPage(
      name: Routes.singUpPatientPage,
      page: () => const SingUpPatientPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.addUrgencyPage,
      page: () => const AddUrgencyPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.mainScreen,
      page: () => const MainScreen(),
      bindings: [
        AuthBinding(),
        // MainBinding(),
      ],
    ),
    //for urgancy
    GetPage(
      name: Routes.detialUrgance,
      page: () => const DetailUrgence(),
      binding: AuthBinding(),
    ),
    // //for messages
    // GetPage(
    //   name: Routes.messageScreen,
    //   page: () => const MessageScreen(),
    //   binding: AuthBinding(),
    // ),
    //sign up the doctor
    GetPage(
      name: Routes.signUpScreenDoctor,
      page: () => const SignUpScreenDoctor(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.singUpDoctorPage,
      page: () => const SingUpDoctorPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.mainScreenDoctor,
      page: () => const MainScreenDoctor(),
      bindings: [
        AuthBinding(),
        // MainBinding(),
      ],
    ),
  ];
}

class Routes {
  //principale pages
  static const welcomeScreen = '/welcomeScreen';
  static const loginScreen = '/loginScreen';
  static const signUpScreen = '/signUpScreen';
  static const forgetPasswordScreen = '/forgetPasswordScreen';
  //the ptient screens
  static const signUpScreenPatient = '/signUpScreenPatient';
  static const singUpPatientPage = '/singUpPatientPage';
  static const addUrgencyPage = '/addUrgencyPage';
  static const mainScreen = '/mainScreen';
  //for thee urgancy
  static const detialUrgance = '/detialUrgance';
  //for thee messages
  static const messageScreen = '/messageScreen';
  //the doctor screens
  static const signUpScreenDoctor = '/signUpScreenDoctor';
  static const singUpDoctorPage = '/singUpDoctorPage';
  static const mainScreenDoctor = '/mainScreenDoctor';
}
