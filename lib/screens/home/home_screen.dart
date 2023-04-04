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
            return AppBar(
              title: Text("Home - ${user.name}"),
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
                final medications = user.medications ?? [];
                return Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Name: ${user.name}"),
                        Text("Email: ${user.email}"),
                        Text("É idoso: ${user.isOlderly}"),
                        Text("Medicamentos:"),
                        if (medications.isNotEmpty)
                          Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemCount: medications.length,
                              itemBuilder: (_, index) {
                                final medication = medications[index];
                                return Container(
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    title: Text(medication['name']),
                                    subtitle: Text(
                                      "Quantidade: ${medication['quantity']}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        user.deleteMedication(
                                          medication['name'],
                                        );
                                        homeController.user.value = user;
                                        homeController.user.refresh();
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        else
                          const Text("Nenhum medicamento cadastrado"),
                        // Exibir medicamentos aqui
                      ],
                    ),
                  ),
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
