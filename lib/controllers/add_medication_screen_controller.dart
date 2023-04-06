// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMedicationScreenController extends GetxController {
  final _auth = FirebaseAuth.instance;
  RxString frequency = 'apenas alguns dias na semana'.obs;
  RxList<String> daysSelected = <String>[].obs;
  RxList<String> timesSelected = <String>[].obs;
  RxList<DateTime> datesSelected = <DateTime>[].obs;

  void setFrequency(String value) {
    print(value);
    frequency.value = value;
  }

  void toggleDay(String day) {
    if (daysSelected.contains(day)) {
      daysSelected.remove(day);
      print(daysSelected);
    } else {
      daysSelected.add(day);
      print(daysSelected);
    }
  }

  void toggleTime(String time) {
    if (timesSelected.contains(time)) {
      timesSelected.remove(time);
      print(timesSelected);
    }
  }

  void toggleDate(DateTime date) {
    if (datesSelected.contains(date)) {
      datesSelected.remove(date);
      print(datesSelected);
    }
  }

  void saveMedication(
      String name, String quantity, GlobalKey<FormState> formkey) {
    final medication = {
      'name': name,
      'quantity': quantity,
      'frequency': frequency.value,
      'daysSelected': daysSelected.toList(),
      'timesSelected': timesSelected.toList(),
      'datesSelected': datesSelected.toList(),
    };

    if (frequency.value == 'apenas em datas especificas') {
      if (datesSelected.isEmpty) {
        Get.snackbar('Erro', 'Selecione as datas');
        return;
      }
    } else if (frequency.value == 'apenas alguns dias na semana') {
      if (daysSelected.isEmpty) {
        Get.snackbar('Erro', 'Selecione os dias');
        return;
      }
    } else if (frequency.value == 'todos os dias') {
      if (timesSelected.isEmpty) {
        Get.snackbar('Erro', 'Selecione os horários');
        return;
      }
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .update({
      'medications': FieldValue.arrayUnion([medication])
    });
    Get.snackbar(
      'Sucesso',
      'Medicação adicionada com sucesso',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    Get.offAllNamed('/home');
  }
}
