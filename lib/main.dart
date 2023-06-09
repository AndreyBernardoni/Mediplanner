import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplanner/firebase_options.dart';
import 'package:mediplanner/repository/authentication_repository.dart';
import 'package:mediplanner/screens/medication_details/medication_details_screen.dart';
import 'package:mediplanner/screens/signup/signup_screen.dart';
import 'package:mediplanner/screens/add_medication/add_medication_screen.dart';

import 'screens/home/home_screen.dart';
import 'screens/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthenticationRepository());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      getPages: [
        GetPage(
          name: '/signup',
          page: () => const SignUpScreen(),
        ),
        GetPage(
          name: '/login',
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: '/home',
          page: () => HomeScreen(),
        ),
        GetPage(
          name: "/addMedicationScreen",
          page: () => AddMedicationScreen(),
        ),
        GetPage(
          name: "/medicationDetailsScreen",
          page: () => const MedicationDetailsScreen(),
        ),
      ],
    );
  }
}
