// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplanner/controllers/add_medication_screen_controller.dart';

class AddMedicationScreen extends StatelessWidget {
  final AddMedicationScreenController controller =
      Get.put(AddMedicationScreenController());
  final formkey = GlobalKey<FormState>();
  var name = TextEditingController();
  var quantity = TextEditingController();

  AddMedicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Screen'),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Nome'),
                TextField(
                  controller: name,
                  decoration: const InputDecoration(
                    hintText: 'Digite seu nome',
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text('Quantidade'),
                TextField(
                  controller: quantity,
                  decoration: const InputDecoration(
                    hintText: 'Digite a quantidade',
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text('Frequência'),
                DropdownButton(
                  value: controller.frequency.value,
                  onChanged: (value) {
                    controller.setFrequency(value!);
                  },
                  items: const [
                    DropdownMenuItem(
                      value: 'apenas alguns dias na semana',
                      child: Text('Apenas alguns dias na semana'),
                    ),
                    DropdownMenuItem(
                      value: 'em datas especificas',
                      child: Text('Em datas específicas'),
                    ),
                    DropdownMenuItem(
                      value: 'todos os dias',
                      child: Text('Todos os dias'),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                if (controller.frequency.value ==
                    'apenas alguns dias na semana') ...[
                  const Text('Dias da semana'),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      for (final day in [
                        'Seg',
                        'Ter',
                        'Qua',
                        'Qui',
                        'Sex',
                        'Sáb',
                        'Dom'
                      ])
                        GestureDetector(
                          onTap: () {
                            controller.toggleDay(day);
                            if (controller.daysSelected.length == 7) {
                              controller.daysSelected.clear();
                              controller.frequency.value = 'todos os dias';
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0),
                              color: controller.daysSelected.contains(day)
                                  ? Colors.blue
                                  : null,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Text(day),
                          ),
                        ),
                    ],
                  ),
                ],
                if (controller.frequency.value == 'em datas especificas') ...[
                  const Text('Datas selecionadas'),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      for (final date in controller.datesSelected)
                        GestureDetector(
                          onTap: () => controller.datesSelected.remove(date),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child:
                                Text('${date.day}/${date.month}/${date.year}'),
                          ),
                        ),
                      GestureDetector(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (controller.datesSelected.length >= 3) {
                            Get.snackbar("Atenção!",
                                "Limite Máximo de Datas Selecionados!",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                          } else if (pickedDate != null) {
                            pickedDate = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                            );
                            controller.datesSelected.add(pickedDate);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.blue,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: const Text('Adicionar data'),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 16.0),
                const Text('Horários'),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    for (final time in controller.timesSelected)
                      GestureDetector(
                        onTap: () {
                          controller.timesSelected.remove(time);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Text(time),
                        ),
                      ),
                    GestureDetector(
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (controller.timesSelected.length >= 3) {
                          Get.snackbar("Atenção!",
                              "Limite Máximo de Horários Selecionados!",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white);
                        } else {
                          if (pickedTime != null) {
                            controller.timesSelected.add(
                                '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}');
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.blue,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: const Text('Adicionar horário'),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.saveMedication(
                        name.text, quantity.text, formkey);
                  },
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
