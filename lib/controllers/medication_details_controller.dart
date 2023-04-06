import 'package:get/get.dart';
import '../models/user_model.dart';

class MedicationDetailsController extends GetxController {
  final UserModel user;
  final int medicationIndex;

  MedicationDetailsController(
      {required this.user, required this.medicationIndex});

  void deleteMedication() {
    final medicationName = user.medications![medicationIndex]['name'];
    user.deleteMedication(medicationName);
    Get.back();
  }

  void editMedication(String name, String quantity, String frequency) {
    final medication = user.medications![medicationIndex];
    medication['name'] = name;
    medication['quantity'] = quantity;
    medication['frequency'] = frequency;
    user.medications![medicationIndex] = medication;
    Get.back();
  }
}
