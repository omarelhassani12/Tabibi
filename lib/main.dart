import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabibi/logic/controllers/auth_controller.dart';
import 'package:tabibi/routes/routes.dart';
import 'package:tabibi/utils/theme.dart';
import 'package:tabibi/view/screens/welcome_screen.dart';

void main() {
  // Get.put(MainController());
  //WidgetsFlutterBinding.ensureInitialized();
  // Get.lazyPut(() => MainController());

  Get.put(AuthController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TABIBI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
        useMaterial3: true,
      ),
      // supportedLocales: [
      //   Locale('en', 'US'), // English
      //   Locale('fr', 'FR'), // French
      //   Locale('ar', 'SA'), // Arabic
      //   Locale('am', 'MA'), // Amazigh
      // ],
      // localizationsDelegates: [
      //   AppLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      home: const SplashScreen(),
      // initialRoute: AppRoutes.welcome,
      getPages: AppRoutes.routes,
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
