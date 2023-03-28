import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplanner/repository/authentication_repository.dart';
import 'package:mediplanner/screens/signup/signup_screen.dart';

import 'screens/home/home_screen.dart';
import 'screens/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(
      AuthenticationRepository()); // Adiciona a instância do AuthenticationRepository no Get
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: '/signup',
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
      ],
    );
  }

  // Como fazer rotas nomeadas usando Getx
}
