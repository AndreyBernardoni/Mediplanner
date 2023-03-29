import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplanner/controllers/home_screen_controller.dart.dart';
import 'package:mediplanner/repository/authentication_repository.dart';

import '../../models/user_model.dart';

class HomeScreen extends StatelessWidget {
  final homeController = Get.put(HomeScreenController());
  final authController = Get.put(AuthenticationRepository());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: Obx(() {
          final user = homeController.user.value;
          if (user != null) {
            final userModel = user as UserModel;
            return AppBar(
              title: Text("Home - ${userModel.name}"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    authController.logout();
                  },
                )
              ],
            );
          } else {
            return AppBar(
              title: const Text("Home"),
            );
          }
        }),
      ),
      body: Center(
        child: Column(
          children: [
            Obx(() {
              final user = homeController.user.value;
              if (user != null) {
                final userModel = user as UserModel;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Name: ${userModel.name}"),
                    Text("Email: ${userModel.email}"),
                    Text("É idoso: ${userModel.isOlderly}")
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            }),
            ElevatedButton(
              onPressed: () {
                Get.offAllNamed("/addMedicationScreen");
              },
              child: const Text("Adicionar Medicamento"),
            ),
          ],
        ),
      ),
    );
  }
}
