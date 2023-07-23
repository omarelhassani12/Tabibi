import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabibi/languages/transliations.dart';
import 'package:tabibi/logic/controllers/auth_controller.dart';
import 'package:tabibi/routes/routes.dart';
import 'package:tabibi/view/screens/auth/login_screen.dart';
import 'package:tabibi/view/screens/doctor/main_screen_doctor.dart';
import 'package:tabibi/view/screens/patient/main_screen_patient.dart';
import 'package:tabibi/view/screens/welcome_screen.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

bool isTokenValid(String token) {
  try {
    final decodedToken = JwtDecoder.decode(token);
    final expirationDate =
        DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
    final currentDate = DateTime.now();

    return expirationDate.isAfter(currentDate);
  } catch (e) {
    return false;
  }
}

void main() async {
  Get.put(AuthController());
  Get.put(DoctorController());

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences cache = await SharedPreferences.getInstance();
  String? token = cache.getString('token');

  runApp(MyApp(token ?? ""));
}

class MyApp extends StatelessWidget {
  final String token;
  MyApp(this.token);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TABIBI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      translations: Translation(),
      locale: Locale('fr'),
      fallbackLocale: Locale('fr'),
      home: isTokenValid(token) ? WelcomeScreen() : getHomeScreen(),
      getPages: AppRoutes.routes,
    );
  }

  Widget getHomeScreen() {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          SharedPreferences prefs = snapshot.data!;
          String? role = prefs.getString('role');

          if (role == 'Doctor') {
            return MainScreenDoctor();
          } else if (role == 'Patient') {
            return MainScreen();
          } else {
            return LoginScreen();
          }
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error fetching SharedPreferences'),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'icons/icon.png',
          width: 400,
          height: 400,
        ),
      ),
    );
  }
}


// bool isTokenValid(String token) {
//   try {
//     final decodedToken = JwtDecoder.decode(token);
//     final expirationDate =
//         DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
//     final currentDate = DateTime.now();

//     return expirationDate.isAfter(currentDate);
//   } catch (e) {
//     return false;
//   }
// }

// void main() async {
//   Get.put(AuthController());
//   Get.put(DoctorController());

//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences cache = await SharedPreferences.getInstance();
//   String? token = cache.getString('token');
//   runApp(MyApp(token ?? ""));
// }

// class MyApp extends StatelessWidget {
//   final String token;
//   MyApp(this.token);

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'TABIBI',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.light(),
//       translations: Translation(),
//       locale: Locale('fr'),
//       fallbackLocale: Locale('fr'),
//       home: isTokenValid(token) ? WelcomeScreen() : getHomeScreen(),
//       getPages: AppRoutes.routes,
//     );
//   }

//   Widget getHomeScreen() {
//     return FutureBuilder<SharedPreferences>(
//       future: SharedPreferences.getInstance(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           SharedPreferences prefs = snapshot.data!;
//           String? role = prefs.getString('role');

//           if (role == 'Doctor') {
//             return MainScreenDoctor();
//           } else if (role == 'Patient') {
//             return MainScreen();
//           } else {
//             return LoginScreen();
//           }
//         } else if (snapshot.hasError) {
//           return Scaffold(
//             body: Center(
//               child: Text('Error fetching SharedPreferences'),
//             ),
//           );
//         } else {
//           return CircularProgressIndicator();
//         }
//       },
//     );
//   }
// }

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(const Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const WelcomeScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Image.asset(
//           'icons/icon.png',
//           width: 400,
//           height: 400,
//         ),
//       ),
//     );
//   }
// }






















// bool isTokenValid(String token) {
//   try {
//     final decodedToken = JwtDecoder.decode(token);
//     final expirationDate =
//         DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
//     final currentDate = DateTime.now();

//     return expirationDate.isAfter(currentDate);
//   } catch (e) {
//     return false;
//   }
// }

// void main() async {
//   await GetStorage.init();
//   Get.put(AuthController());
//   Get.put(DoctorController());

//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences cache = await SharedPreferences.getInstance();
//   String? token = cache.getString('token');
//   runApp(MyApp(token ?? ""));
// }

// class MyApp extends StatelessWidget {
//   final String token;
//   MyApp(this.token);

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'TABIBI',
//       debugShowCheckedModeBanner: false,
//       theme: Get.put(ThemeService()).getThemeData(),
//       darkTheme: ThemeService().darkTheme,
//       themeMode: ThemeService().getThemeMode(),
//       translations: Translation(),
//       locale: Locale('fr'),
//       fallbackLocale: Locale('fr'),
//       home: isTokenValid(token) ? WelcomeScreen() : getHomeScreen(),
//       getPages: AppRoutes.routes,
//     );
//   }

//   Widget getHomeScreen() {
//     return FutureBuilder<SharedPreferences>(
//       future: SharedPreferences.getInstance(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           SharedPreferences prefs = snapshot.data!;
//           String? role = prefs.getString('role');

//           if (role == 'Doctor') {
//             return MainScreenDoctor();
//           } else if (role == 'Patient') {
//             return MainScreen();
//           } else {
//             return LoginScreen();
//           }
//         } else if (snapshot.hasError) {
//           return Scaffold(
//             body: Center(
//               child: Text('Error fetching SharedPreferences'),
//             ),
//           );
//         } else {
//           return CircularProgressIndicator();
//         }
//       },
//     );
//   }
// }

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(const Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const WelcomeScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Image.asset(
//           'icons/icon.png',
//           width: 400,
//           height: 400,
//         ),
//       ),
//     );
//   }
// }












// bool isTokenValid(String token) {
//   try {
//     final decodedToken = JwtDecoder.decode(token);
//     final expirationDate =
//         DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
//     final currentDate = DateTime.now();

//     return expirationDate.isAfter(currentDate);
//   } catch (e) {
//     return false;
//   }
// }

// void main() async {
//   Get.put(AuthController());
//   Get.put(DoctorController());

//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences cache = await SharedPreferences.getInstance();
//   String? token = cache.getString('token');
//   runApp(MyApp(token ?? ""));
// }

// class MyApp extends StatelessWidget {
//   final String token;
//   MyApp(this.token);

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'TABIBI',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.light().copyWith(
//         colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
//         useMaterial3: true,
//       ),
//       home: isTokenValid(token) ? WelcomeScreen() : getHomeScreen(),
//       getPages: AppRoutes.routes,
//     );
//   }

//   Widget getHomeScreen() {
//     return FutureBuilder<SharedPreferences>(
//       future: SharedPreferences.getInstance(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           SharedPreferences prefs = snapshot.data!;
//           String? role = prefs.getString('role');

//           if (role == 'Doctor') {
//             return MainScreenDoctor();
//           } else if (role == 'Patient') {
//             return MainScreen();
//           } else {
//             return LoginScreen();
//           }
//         } else if (snapshot.hasError) {
//           return Scaffold(
//             body: Center(
//               child: Text('Error fetching SharedPreferences'),
//             ),
//           );
//         } else {
//           return CircularProgressIndicator();
//         }
//       },
//     );
//   }
// }

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(const Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const WelcomeScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Image.asset(
//           'icons/icon.png',
//           width: 400,
//           height: 400,
//         ),
//       ),
//     );
//   }
// }
































































// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tabibi/logic/controllers/auth_controller.dart';
// import 'package:tabibi/routes/routes.dart';
// import 'package:tabibi/utils/theme.dart';
// import 'package:tabibi/view/screens/doctor/main_screen_doctor.dart';
// import 'package:tabibi/view/screens/patient/main_screen_patient.dart';
// import 'package:tabibi/view/screens/welcome_screen.dart';

// import 'package:jwt_decoder/jwt_decoder.dart';

// bool isTokenValid(String token) {
//   try {
//     final decodedToken = JwtDecoder.decode(token);
//     final expirationDate =
//         DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
//     final currentDate = DateTime.now();

//     return expirationDate.isAfter(currentDate);
//   } catch (e) {
//     return false;
//   }
// }

// void main() async {
//   Get.put(AuthController());
//   Get.put(DoctorController());

//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences cache = await SharedPreferences.getInstance();
//   String? token = cache.getString('token');
//   runApp(MyApp(token ?? ""));
// }

// class MyApp extends StatelessWidget {
//   final String token;
//   MyApp(this.token);

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'TABIBI',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
//         useMaterial3: true,
//       ),
//       home: isTokenValid(token) ? WelcomeScreen() : getHomeScreen(),
//       getPages: AppRoutes.routes,
//     );
//   }

//   Widget getHomeScreen() {
//     return FutureBuilder<SharedPreferences>(
//       future: SharedPreferences.getInstance(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           SharedPreferences prefs = snapshot.data!;
//           String? role =
//               prefs.getString('role'); // Fetch the role from preferences

//           if (role == 'Doctor') {
//             return MainScreenDoctor(); // Replace with your doctor's home screen
//           } else if (role == 'Patient') {
//             return MainScreen(); // Replace with your patient's home screen
//           } else {
//             // Handle invalid or unknown role
//             return Scaffold(
//               body: Center(
//                 child: Text('Invalid user role'),
//               ),
//             );
//           }
//         } else if (snapshot.hasError) {
//           // Handle any errors that occurred while fetching SharedPreferences
//           return Scaffold(
//             body: Center(
//               child: Text('Error fetching SharedPreferences'),
//             ),
//           );
//         } else {
//           // While waiting for the future to complete, show a loading indicator
//           return CircularProgressIndicator();
//         }
//       },
//     );
//   }
// }

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(const Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const WelcomeScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Image.asset(
//           'icons/icon.png',
//           width: 400,
//           height: 400,
//         ),
//       ),
//     );
//   }
// }














































// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tabibi/logic/controllers/auth_controller.dart';
// import 'package:tabibi/routes/routes.dart';
// import 'package:tabibi/utils/theme.dart';
// import 'package:tabibi/view/screens/doctor/main_screen_doctor.dart';
// import 'package:tabibi/view/screens/patient/main_screen_patient.dart';
// import 'package:tabibi/view/screens/welcome_screen.dart';

// import 'package:jwt_decoder/jwt_decoder.dart';

// bool isTokenValid(String token) {
//   try {
//     final decodedToken = JwtDecoder.decode(token);
//     final expirationDate =
//         DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
//     final currentDate = DateTime.now();

//     return expirationDate.isAfter(currentDate);
//   } catch (e) {
//     return false;
//   }
// }

// void main() async {
//   Get.put(AuthController());
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences cache = await SharedPreferences.getInstance();
//   String? token = cache.getString('token');
//   runApp(MyApp(token!));
// }

// class MyApp extends StatelessWidget {
//   final String token;
//   MyApp(this.token);
//   // const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'TABIBI',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
//         useMaterial3: true,
//       ),
//       home: token != null && isTokenValid(token)
//           ? WelcomeScreen()
//           : getHomeScreen(),

//       // home: const SplashScreen(),
//       // initialRoute: AppRoutes.welcome,
//       getPages: AppRoutes.routes,
//     );
//   }

//   Widget getHomeScreen() {
//     return FutureBuilder<SharedPreferences>(
//       future: SharedPreferences.getInstance(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           SharedPreferences prefs = snapshot.data!;
//           String? role =
//               prefs.getString('role'); // Fetch the role from preferences

//           if (role == 'Doctor') {
//             return MainScreenDoctor(); // Replace with your doctor's home screen
//           } else if (role == 'Patient') {
//             return MainScreen(); // Replace with your patient's home screen
//           } else {
//             // Handle invalid or unknown role
//             return Scaffold(
//               body: Center(
//                 child: Text('Invalid user role'),
//               ),
//             );
//           }
//         } else if (snapshot.hasError) {
//           // Handle any errors that occurred while fetching SharedPreferences
//           return Scaffold(
//             body: Center(
//               child: Text('Error fetching SharedPreferences'),
//             ),
//           );
//         } else {
//           // While waiting for the future to complete, show a loading indicator
//           return CircularProgressIndicator();
//         }
//       },
//     );
//   }
// }

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(const Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const WelcomeScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Image.asset(
//           'icons/icon.png',
//           width: 400,
//           height: 400,
//         ),
//       ),
//     );
//   }
// }
