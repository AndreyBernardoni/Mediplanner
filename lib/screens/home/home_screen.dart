import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplanner/controllers/home_screen_controller.dart.dart';
import 'package:mediplanner/repository/authentication_repository.dart';

import '../medication_details/medication_details_screen.dart';

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
                        const Text("Medicamentos:"),
                        if (medications.isNotEmpty)
                          Expanded(
                            child: GridView.builder(
                              itemCount: medications.length,
                              itemBuilder: (_, index) {
                                final medication = medications[index];
                                return GestureDetector(
                                  onTap: () {},
                                  child: Card(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Nome: ${medication['name']}"),
                                        Text(
                                            "Dosagem: ${medication['quantity']}"),
                                        Text("Frequência: "
                                            "${medication['frequency']}"),
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.toNamed(
                                                "/medicationDetailsScreen",
                                                arguments:
                                                    const MedicationDetailsScreen());
                                          },
                                          child: const Text("Editar"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            user.deleteMedication(
                                                medication['name']);
                                            homeController.user.refresh();
                                          },
                                          child: const Text(
                                            "Excluir",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
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
